[string []] $schematic = (Get-Content "$PSScriptRoot/input.txt")

[int] $sum = 0
$number = ""
$start = 0

function Get-PartNumber ([string] $number, [int] $y, [int] $start) {
  for ($j = $y - 1; $j -le $y + 1; $j++) {
    for ($i = $start - 1; $i -le $start + $number.Length; $i++) {
      if ($j -lt 0 -or $j -ge $schematic.Count -or $i -lt 0 -or $i -ge $schematic[$j].Length -or ($j -eq $y -and $i -ge $start -and $i -le ($start + $number.Length - 1))) {
        continue
      }

      [char] $c = $schematic[$j][$i]
      if ($c -notmatch '[0-9\.]') {
        return [int] $number
      }
    }
  }

  return 0
}

for ($y = 0; $y -lt $schematic.Count; $y++) {
  for ($x = 0; $x -lt $schematic[$y].Length; $x++) {
    [char] $c = $schematic[$y][$x]

    if ($c -match '\d') {
      if ($number.Length -eq 0) {
        $start = $x
      }
      $number += $c
    }
    if ($c -notmatch '\d' -or $x -eq $schematic[$y].Length - 1) {
      if ($number.Length -gt 0) {
        $partNumber = (Get-PartNumber $number $y $start)
        if ($partNumber -gt 0) {
          Write-Debug "Found part number $partNumber at $($y + 1), $($start + 1)"
          $sum += $partNumber
        }
        $number = ""
      }
    }
  }
}

$sum
