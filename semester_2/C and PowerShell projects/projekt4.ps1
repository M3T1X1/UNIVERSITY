Write-Host "1. Kamien"
Write-Host "2. Papier"
Write-Host "3. Scyzoryk"
$wejscieGracza = Read-Host "Wybierz przedmiot "


if ($wejscieGracza -match '^\d+$') {
    $wyborGracza = [int]$wejscieGracza
} else {
    Write-Host "`nWybrano zly przedmiot."
    exit
}

if ($wyborGracza -notin 1..3) {
    Write-Host "`nNiepoprawny wybor przedmiotu."
    exit
}

$wyborKomputera = Get-Random -Minimum 1 -Maximum 4
$przedmioty = @("Kamien", "Papier", "Scyzoryk")

switch ($wyborGracza) {
    1 {
        if ($wyborKomputera -eq 1) { Write-Host "`nKomputer wylosowal $($przedmioty[0]) i jest remis." }
        elseif ($wyborKomputera -eq 2) { Write-Host "`nKomputer wylosowal $($przedmioty[1]) i wygral." }
        elseif ($wyborKomputera -eq 3) { Write-Host "`nKomputer wylosowal $($przedmioty[2]) i wygrywasz." }
    }
    2 {
        if ($wyborKomputera -eq 1) { Write-Host "`nKomputer wylosowal $($przedmioty[0]) i wygrywasz." }
        elseif ($wyborKomputera -eq 2) { Write-Host "`nKomputer wylosowal $($przedmioty[1]) i jest remis." }
        elseif ($wyborKomputera -eq 3) { Write-Host "`nKomputer wylosowal $($przedmioty[2]) i wygral." }
    }
    3 {
        if ($wyborKomputera -eq 1) { Write-Host "`nKomputer wylosowal $($przedmioty[0]) i wygral." }
        elseif ($wyborKomputera -eq 2) { Write-Host "`nKomputer wylosowal $($przedmioty[1]) i przegral." }
        elseif ($wyborKomputera -eq 3) { Write-Host "`nKomputer wylosowal $($przedmioty[2]) i jest remis." }
    }
    default {
        Write-Host "`nNiepoprawny wybor przedmiotu."
    }
}
