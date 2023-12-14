<?php
// API endpoint URL
$apiUrl = "http://cnc-api:3000/read/info";

// Fetch data from the API
$data = file_get_contents($apiUrl);

// Check if the request was successful
if ($data === false) {
    die("Failed to fetch data from the API.");
}

// Parse the JSON data and assign it to $cronjobs
$cronjobs = json_decode($data, true);

// Check if the JSON was successfully parsed
if ($cronjobs === null) {
    die("Failed to parse JSON data.");
}
?>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="../style.css">
    <script>
        // Function to filter the table rows based on user input
        function searchTable() {
            var input, filter, table, tr, td, i, txtValue;
            input = document.getElementById("searchInput");
            filter = input.value.toUpperCase();
            table = document.getElementById("overviewData"); // Use a separate table for data rows
            tr = table.getElementsByTagName("tr");

            for (i = 0; i < tr.length; i++) {
                tr[i].style.display = "none"; // Hide all data rows by default
                td = tr[i].getElementsByTagName("td")[0]; // Change the index to match the column you want to search
                if (td) {
                    txtValue = td.textContent || td.innerText;
                    if (txtValue.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = ""; // Display the data row if a match is found
                    }
                }
            }
        }
    </script>
</head>
<body>
    <div class="overskift">
        <h1>Overview</h1>
        <a href="../Php/packages.php">Packages</a>
        <a href="../Php/cronjob.php">Cronjobs</a>
        <a href="../Php/overview.php">Overview</a>
        <br>
        <input type="text" id="searchInput" onkeyup="searchTable()" placeholder="Search for Hostname...">
    </div>

    <div class="table-container">
        <!-- Table for headers -->
        <table id="overviewTable">
            <tr>
                <th>Hostname</th>
                <th>IP Address</th>
                <th>MAC Address</th>
                <th>Distro</th>
                <th>Package Updates</th>
            </tr>
        </table>

        <!-- Table for data rows -->
        <table id="overviewData">
            <?php foreach ($cronjobs as $cronjob): ?>
                <tr>
                    <td><?php echo $cronjob['hostname']; ?></td>
                    <td><?php echo $cronjob['ipaddress']; ?></td>
                    <td><?php echo $cronjob['macaddress']; ?></td>
                    <td><?php echo $cronjob['distro']; ?></td>
                    <td><?php echo $cronjob['packages']; ?></td>
                </tr>
            <?php endforeach; ?>
        </table>
    </div>
</body>
</html>