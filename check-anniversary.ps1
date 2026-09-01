Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -ErrorAction SilentlyContinue



$csvPath = Join-Path $PSScriptRoot "employees.csv"

$today = Get-Date

Write-Host "================================="
Write-Host "Joining Anniversary Checker"
Write-Host "Today's Date: $($today.ToString('yyyy-MM-dd'))"
Write-Host "================================="

$employees = Import-Csv $csvPath

$found = $false

foreach ($employee in $employees) {

    $joiningDate = [datetime]::ParseExact(
        $employee.JoiningDate,
        "yyyy-MM-dd",
        $null
    )

    if (($joiningDate.Month -eq $today.Month) -and
        ($joiningDate.Day -eq $today.Day)) {

        $years = $today.Year - $joiningDate.Year

        Write-Host ""
        Write-Host "WORK ANNIVERSARY FOUND!"
        Write-Host "Employee : $($employee.Name)"
        Write-Host "Email    : $($employee.Email)"
        Write-Host "Joined   : $($employee.JoiningDate)"
        Write-Host "Years    : $years"

        # Windows Notification
        

        $found = $true
    }
}

if ($found -eq $false) {
    Write-Host ""
    Write-Host "No joining anniversary today."
}