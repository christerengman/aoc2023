$digits = @('one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine')

function Get-Digit ([string] $s, [int] $start, [int] $step) {
  # Numerical digit
  if ($s[$start] -match '\d') {
    return $s[$start]
  }

  # Lexical digit
  for ($i = 0; $i -lt $digits.Count; $i++) {
    if ($s.Substring($start).StartsWith($digits[$i])) {
      return "$($i + 1)"
    }
  }

  # Recurse
  return Get-Digit $s ($start + $step) $step
}

Get-Content "$PSScriptRoot/input.txt" |
ForEach-Object {
  $sum1 = 0
  $sum2 = 0
} {
  # Part 1
  if ($_ -match '^\D*(\d).*?(\d)?\D*$') {
    $first = $Matches[1]
    $last = $Matches[2] ?? $first
    $value = [int] "$first$last"
    $sum1 += $value
  }

  # Part 2
  $first = Get-Digit $_ 0 1
  $last = Get-Digit $_ ($_.Length - 1) -1
  $value = [int] "$first$last"
  $sum2 += $value

} {
  $sum1
  $sum2
}
