<#
    Clear-Spooler.ps1
    Stops the Print Spooler, clears its queue, and restarts it.
    Run this script as Administrator.
#>

# Stop the Print Spooler service
Write-Host "Stopping Print Spooler..."
Stop-Service -Name Spooler -Force -ErrorAction SilentlyContinue

# Remove all files from the spooler folder
Write-Host "Clearing print queue files..."
$queuePath = "$env:SystemRoot\System32\spool\PRINTERS\*"
Remove-Item -Path $queuePath -Recurse -Force -ErrorAction SilentlyContinue

# Start the Print Spooler service again
Write-Host "Starting Print Spooler..."
Start-Service -Name Spooler -ErrorAction SilentlyContinue

# Old Reddit command, remove?
Get-Printer | Get-PrintJob | Where-Object JobStatus -like '*error*' | Remove-PrintJob

Write-Host "Complete."
