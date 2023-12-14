<?php
// API endpoint URL
$apiUrl = "http://cnc-api:3000/read/cronjobs";

// Fetch data from the API
$data = file_get_contents($apiUrl);

// Check if the request was successful
if ($data === false) {
    die("Failed to fetch data from the API.");
}

// Parse the JSON data
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
        // Function to filter the table based on user input
        function filterTable() {
            var input, filter, table, tr, td, i, j, txtValue;
            input = document.getElementById("searchInput");
            filter = input.value.toUpperCase();
            table = document.getElementById("cronjobsTable");
            tr = table.getElementsByTagName("tr");
            for (i = 1; i < tr.length; i++) {
                tr[i].style.display = "none"; // Hide all data rows initially
                td = tr[i].getElementsByTagName("td");
                for (j = 0; j < td.length; j++) {
                    txtValue = td[j].textContent || td[j].innerText;
                    if (txtValue.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = ""; // Show the data row if a match is found
                        break; // No need to check other columns
                    }
                }
            }
        }
    </script>
</head>
<body>
    <div class="overskift">
        <h1>Cronjobs</h1>
        <a href="../Php/packages.php">Packages</a>
        <a href="../Php/cronjob.php">Cronjobs</a>
        <a href="../Php/overview.php">Overview</a>
        <br>
        <input type="text" id="searchInput" onkeyup="filterTable()" placeholder="Search for Cronjobs...">
    </div>

    <div class="table-container">
        <!-- Table for headers -->
        <table id="cronjobsTable">
            <tr>
                <th>Hostname</th>
                <th>Cronjob Script</th>
            </tr>
        </table>

        <!-- Table for data rows -->
        <table id="cronjobsData">
            <?php foreach ($cronjobs as $cronjob): ?>
                <tr>
                    <td><?php echo $cronjob['hostname']; ?></td>
                    <td><?php echo $cronjob['cronjobsscripts']; ?></td>
                </tr>
            <?php endforeach; ?>
        </table>
    </div>
</body>
</html>