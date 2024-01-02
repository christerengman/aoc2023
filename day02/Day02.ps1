Get-Content "$PSScriptRoot/input.txt" |
ForEach-Object {
  if ($_ -match '^Game (\d+): (.*)$') {
    $game = $Matches[1]
    $rounds = $Matches[2] -split '; ' | ForEach-Object {
      $_ -split ', ' | ForEach-Object {
        if ($_ -match '(\d+) (\w+)') {
          [PSCustomObject]@{
            Count = [int] $Matches[1]
            Color = $Matches[2]
          }
        }
      }
    }
    $rounds | Group-Object Color | ForEach-Object {
      [PSCustomObject]@{
        Game = $game
        Color = $_.Name
        Max = ($_.Group | Measure-Object Count -Maximum).Maximum
      }
    }
  }
} |
Where-Object { ($_.Color -eq 'red' -and $_.Max -le 12) -or ($_.Color -eq 'green' -and $_.Max -le 13) -or ($_.Color -eq 'blue' -and $_.Max -le 14) } |
Group-Object Game -NoElement |
Where-Object { $_.Count -eq 3 } |
Measure-Object Name -Sum |
Select-Object Sum
