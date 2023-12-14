const express = require('express');
const bodyParser = require('body-parser');
const { Client } = require('ssh2');
const pgp = require('pg-promise')();
const db = pgp('postgresql://root:12Marvel@cnc-db:5432/machines');

const app = express();
app.use(bodyParser.json());

// Create a new server record
app.post('/servers', async (req, res) => {
  const { name, ip_address, ssh_username, ssh_password } = req.body;

  const newServer = await db.one(
    'INSERT INTO servers(name, ip_address, ssh_username, ssh_password) VALUES($1, $2, $3, $4) RETURNING *',
    [name, ip_address, ssh_username, ssh_password]
  );

  res.json(newServer);
});

// Read server information
app.get('/servers', async (req, res) => {
  const servers = await db.any('SELECT * FROM servers');
  res.json(servers);
});

// Update server information
app.put('/servers/:id', async (req, res) => {
  const { id } = req.params;
  const { name, ip_address, ssh_username, ssh_password } = req.body;

  const updatedServer = await db.oneOrNone(
    'UPDATE servers SET name=$1, ip_address=$2, ssh_username=$3, ssh_password=$4 WHERE id=$5 RETURNING *',
    [name, ip_address, ssh_username, ssh_password, id]
  );

  if (updatedServer) {
    res.json(updatedServer);
  } else {
    res.status(404).send('Server not found');
  }
});

// Delete a server record
app.delete('/servers/:id', async (req, res) => {
  const { id } = req.params;

  const deletedServer = await db.oneOrNone('DELETE FROM servers WHERE id=$1 RETURNING *', id);

  if (deletedServer) {
    res.json(deletedServer);
  } else {
    res.status(404).send('Server not found');
  }
});

// Create a route that accepts various SSH commands
app.post('/servers/ssh/:id', async (req, res) => {
  const { id } = req.params;
  const { command } = req.body; // Add a command parameter in the request body

  if (!command) {
    res.status(400).send('Missing command in the request body');
    return;
  }

  const server = await db.oneOrNone('SELECT * FROM servers WHERE id = $1', id);

  if (!server) {
    res.status(404).send('Server not found');
    return;
  }

  const conn = new Client();

  conn.on('ready', () => {
    conn.shell((err, stream) => {
      if (err) {
        conn.end();
        return res.status(500).send('SSH Error: ' + err.message);
      }

      // You can interact with the SSH shell here
      stream.on('data', (data) => {
        res.write(data);
      });

      stream.on('close', () => {
        conn.end();
        res.end();
      });

      // Execute the specified command
      stream.write(`${command}\n`);
    });
  });

  conn.on('error', (err) => {
    res.status(500).send('SSH Error: ' + err.message);
  });

  conn.connect({
    host: server.ip_address,
    port: 22,
    username: server.ssh_username,
    password: server.ssh_password,
  });
});

// Start game servers
app.post('/servers/start/:id', async (req, res) => {
  const { id } = req.params;
  const server = await db.oneOrNone('SELECT * FROM servers WHERE id = $1', id);

  if (!server) {
    res.status(404).send('Server not found');
    return;
  }

  const command = 'start_game_server'; // Replace with the actual command
  await executeSSHCommand(server, command, res);
});

// Stop game servers
app.post('/servers/stop/:id', async (req, res) => {
  const { id } = req.params;
  const server = await db.oneOrNone('SELECT * FROM servers WHERE id = $1', id);

  if (!server) {
    res.status(404).send('Server not found');
    return;
  }

  const command = 'stop_game_server'; // Replace with the actual command
  await executeSSHCommand(server, command, res);
});

// Display running game servers
app.get('/servers/running', async (req, res) => {
  const runningServers = await db.any('SELECT * FROM servers WHERE status = $1', 'running');
  res.json(runningServers);
});

// Display the game server settings
app.get('/servers/settings/:id', async (req, res) => {
  const { id } = req.params;
  const server = await db.oneOrNone('SELECT * FROM servers WHERE id = $1', id);

  if (!server) {
    res.status(404).send('Server not found');
    return;
  }

  res.json(server);
});

// Install and start new game servers
app.post('/servers/install', async (req, res) => {
  // Implement the logic to install and start a new game server based on the request body
  // ...

  res.status(501).send('Not Implemented'); // Placeholder response for functionality not implemented
});

// Helper function to execute SSH commands
async function executeSSHCommand(server, command, res) {
  const conn = new Client();

  conn.on('ready', () => {
    conn.shell((err, stream) => {
      if (err) {
        conn.end();
        return res.status(500).send('SSH Error: ' + err.message);
      }

      // You can interact with the SSH shell here
      stream.on('data', (data) => {
        res.write(data);
      });

      stream.on('close', () => {
        conn.end();
        res.end();
      });

      // Execute the specified command
      stream.write(`${command}\n`);
    });
  });

  conn.on('error', (err) => {
    res.status(500).send('SSH Error: ' + err.message);
  });

  conn.connect({
    host: server.ip_address,
    port: 22,
    username: server.ssh_username,
    password: server.ssh_password,
  });
}

const PORT = process.env.PORT || 3001;

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
