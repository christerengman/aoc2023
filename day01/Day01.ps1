Get-Content "$PSScriptRoot/input.txt" |
ForEach-Object {
  $sum = 0
} {
  if ($_ -match '^\D*(\d).*?(\d)?\D*$') {
    $first = $Matches[1]
    $last = $Matches[2] ?? $first
    $value = [int] "$first$last"
    Write-Debug "$_ : $value"
    $sum += $value
  }
} {
  $sum
}
