Function get-header {
    cls
    Write-Host "-----------------------------------------------------------------------" -ForegroundColor White;
    Write-Host "-                                                                     -" -ForegroundColor White;
    Write-Host "-  Mini Script          /^--^\     /^--^\     /^--^\                  -" -ForegroundColor White;
    Write-Host "-    Pre-Upgrade        \____/     \____/     \____/                  -" -ForegroundColor White;
    Write-Host "-                      /      \   /      \   /      \                 -" -ForegroundColor White;
    Write-Host "-    A.Novoa          |        | |        | |        |                -" -ForegroundColor White;
    Write-Host "-                      \__  __/   \__  __/   \__  __/                 -" -ForegroundColor White;
    Write-Host "-|^|^|^|^|^|^|^|^|^|^|^|^|\ \|^|^|^|/ /|^|^|^|^|\ \|^|^|^|^|^|^|^|^|^|-" -ForegroundColor White;
    Write-Host "-| | | | | | | | | | | | | \ \ | | / / | | | | | \ \ | | | | | | | | |-" -ForegroundColor White;
    Write-Host "-##########################/ /#####\ \###########/ /##################-" -ForegroundColor White;
    Write-Host "-| | | | | | | | | | | | | \/| | | |\/ | | | | | \/| | | | | | | | | |-" -ForegroundColor White;
    Write-Host "-|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|-" -ForegroundColor White;
    Write-Host "-----------------------------------------------------------------------" -ForegroundColor White;
}
Import-Module "C:\Program Files (x86)\Microsoft Dynamics 365 Business Central\130\RoleTailored Client\NavModelTools.ps1" -Force

#Rutas folders
$Base = "C:\Test"
$Original =($Base +"\ORIGINAL")
$Modified =($Base +"\MODIFIED")
$Target =($Base +"\TARGET")
$Result =($Base +"\RESULT")
$Temp =($Base +"\TEMP")

#Rutas txt temp
$txtOriginalTemp = ($Temp + "\O.txt")
$txtModifiedTemp = ($Temp + "\M.txt")
$txtTargetTemp = ($Temp + "\T.txt")
$txtResultTemp = ($Result + "\*.txt")

#Rutas txt
$txtOriginal = ($Original + "\O.txt")
$txtModified = ($Modified + "\M.txt")
$txtTarget = ($Target + "\T.txt")
$txtResult = ($Result + "\Resultado.txt")

# ------------------------ Eliminara carpeta principal
get-header
Write-Host "-----------------------------------------------------------------------" -ForegroundColor White;
Write-Host " " -ForegroundColor White;
Write-Host "Si existe la carpeta principal la borrara!." -ForegroundColor Red -BackgroundColor Yellow;
Write-Host " " -ForegroundColor White;
Write-Host "-----------------------------------------------------------------------" -ForegroundColor White;
Write-Host " " -ForegroundColor White;
Read-Host -Prompt "Enter para continuar.."
if (test-path $Base) { DEL $base -Recurse -Force }

# ------------------------ Creara estructura de carpetas
get-header
Write-Host "-----------------------------------------------------------------------" -ForegroundColor White;
Write-Host " " -ForegroundColor White;
Write-Host "Se creara la estructura de carpetas" -ForegroundColor Red -BackgroundColor Yellow;
Write-Host " " -ForegroundColor White;
Write-Host "          + $base " -ForegroundColor Yellow;
Write-Host "               - $Modified " -ForegroundColor Yellow;
Write-Host "               - $Original " -ForegroundColor Yellow;
Write-Host "               - $Result   " -ForegroundColor Yellow;
Write-Host "               - $Target   " -ForegroundColor Yellow;
Write-Host "               - $Temp " -ForegroundColor Yellow;
Write-Host " " -ForegroundColor White;
Write-Host "-----------------------------------------------------------------------" -ForegroundColor White;
Write-Host " " -ForegroundColor White;
Read-Host -Prompt "Enter para continuar.."
New-Item -Path $base -ItemType directory -Force 
Start-Sleep -s 1
New-Item -Path $Original -ItemType directory -Force
Start-Sleep -s 1
New-Item -Path $Modified -ItemType directory -Force
Start-Sleep -s 1
New-Item -Path $Target -ItemType directory -Force
Start-Sleep -s 1
New-Item -Path $Result -ItemType directory -Force
Start-Sleep -s 1
New-Item -Path $Temp -ItemType directory -Force
Start-Sleep -s 1

# ------------------------ Mover archivos de la carpeta temporal a cada una de sus carpetas
get-header
Write-Host "-----------------------------------------------------------------------" -ForegroundColor White;
Write-Host " " -ForegroundColor White;
Write-Host "Se enviara los txt desde las carpetas TEMP a las carpetas correspondientes" -ForegroundColor Red -BackgroundColor Yellow;
Write-Host " " -ForegroundColor White;
Write-Host "   Copiar los .txt a la carpeta TEMP" -ForegroundColor Green;
Write-Host "       - O.txt > txt objetos base de datos origen sin modificaciones" -ForegroundColor Red;
Write-Host "       - M.txt > txt objetos base de datos modificada" -ForegroundColor Red;
Write-Host "       - T.txt > txt objetos base de datos destino" -ForegroundColor Red;
Write-Host " " -ForegroundColor White;
Write-Host "-----------------------------------------------------------------------" -ForegroundColor White;
Write-Host " " -ForegroundColor White;
Read-Host -Prompt "Enter para continuar.."

Move-Item $txtOriginalTemp $txtOriginal
Start-Sleep -s 1
Move-Item $txtModifiedTemp $txtModified
Start-Sleep -s 1
Move-Item $txtTargetTemp $txtTarget

# ------------------------ Se realizara Split de los txt
get-header
Write-Host "-----------------------------------------------------------------------" -ForegroundColor White;
Write-Host " " -ForegroundColor White;
Write-Host "Se realizara split de los .txt" -ForegroundColor Red -BackgroundColor Yellow;
Write-Host " " -ForegroundColor White;
Write-Host "               - $txtModified " -ForegroundColor Yellow;
Write-Host "               - $txtOriginal " -ForegroundColor Yellow;
Write-Host "               - $txtTarget   " -ForegroundColor Yellow;
Write-Host " " -ForegroundColor White;
Write-Host "-----------------------------------------------------------------------" -ForegroundColor White;
Write-Host " " -ForegroundColor White;
Read-Host -Prompt "Enter para continuar.."

Split-NAVApplicationObjectFile -Source $txtOriginal -Destination $Original 
Split-NAVApplicationObjectFile -Source $txtModified -Destination $Modified 
Split-NAVApplicationObjectFile -Source $txtTarget -Destination $Target

# ------------------------ Mover archivos principales de su carpeta a la carpeta TEMP 
get-header
Write-Host "-----------------------------------------------------------------------" -ForegroundColor White;
Write-Host " " -ForegroundColor White;
Write-Host "Se moveran los archivos principales a la carpeta TEMP" -ForegroundColor Red -BackgroundColor Yellow;
Write-Host " " -ForegroundColor White;
Write-Host "-----------------------------------------------------------------------" -ForegroundColor White;
Write-Host " " -ForegroundColor White;
Read-Host -Prompt "Enter para continuar.."

Move-Item $txtOriginal $txtOriginalTemp
Start-Sleep -s 1
Move-Item $txtModified $txtModifiedTemp
Start-Sleep -s 1
Move-Item $txtTarget $txtTargetTemp 

# ------------------------ Se hara merge de los txt 
get-header
Write-Host "-----------------------------------------------------------------------" -ForegroundColor White;
Write-Host " " -ForegroundColor White;
Write-Host "Se hara merge de los txt" -ForegroundColor Red -BackgroundColor Yellow;
Write-Host " " -ForegroundColor White;
Write-Host "-----------------------------------------------------------------------" -ForegroundColor White;
Write-Host " " -ForegroundColor White;
Read-Host -Prompt "Enter para continuar.."

Merge-NAVApplicationObject -OriginalPath $Original -ModifiedPath $Modified -TargetPath $Target -ResultPath $Result

# ------------------------ Se hara join de los txt
get-header
Write-Host "-----------------------------------------------------------------------" -ForegroundColor White;
Write-Host " " -ForegroundColor White;
Write-Host "Se hara un join de los txt" -ForegroundColor Red -BackgroundColor Yellow;
Write-Host " " -ForegroundColor White;
Write-Host "-----------------------------------------------------------------------" -ForegroundColor White;
Write-Host " " -ForegroundColor White;
Read-Host -Prompt "Enter para continuar.." 

Join-NAVApplicationObjectFile -Destination $txtResult -Source $txtResultTemp -Force

# ------------------------ FINAL
get-header
Write-Host "-----------------------------------------------------------------------" -ForegroundColor White;
Write-Host " " -ForegroundColor White;
Write-Host "El archivo se encuentra listo para importar desde la ruta" -ForegroundColor Red -BackgroundColor Yellow;
Write-Host " " -ForegroundColor White;
Write-Host "               - $txtResult " -ForegroundColor Yellow;
Write-Host " " -ForegroundColor White;
Write-Host "-----------------------------------------------------------------------" -ForegroundColor White;
Write-Host " " -ForegroundColor White;
Read-Host -Prompt "Enter para continuar.." 

