function onloadAlert()
{
    alert("Kod zniżkowy 10%: Kod");
}
function resetDropdowns() 
{
    const dropdowns = document.querySelectorAll('select');
    dropdowns.forEach(dropdown => dropdown.selectedIndex = 0);
}

function valuePrint()
{
    const zespol = document.getElementById('zespół');
    const zespolValue = zespol.options[zespol.selectedIndex].text;

    const lokalizacja = document.getElementById('lokalizacja');
    const lokalizacjaValue = lokalizacja.options[lokalizacja.selectedIndex].text;

    const sektor = document.getElementById('sektor');
    const sektorValue = sektor.options[sektor.selectedIndex].text;

    const resultElement = document.getElementById('resultChoices');
    if(zespolValue == "Wybierz zespół" || lokalizacjaValue == "Wybierz lokalizacje" || sektorValue =="Wybierz sektor")
    {
        return -1;
    }
    else
    {
    resultElement.textContent = `${zespolValue},  ${lokalizacjaValue}, ${sektorValue}`;
    }
}

function priceCounter() 
{
    let basePrice = 100;
    let currentValue = 0;

    const zespol = document.getElementById('zespół');
    const zespolValue = zespol.options[zespol.selectedIndex]?.text;

    if(zespolValue === "Amon Amarth") 
    {
        currentValue = basePrice * 1.2;
    } 
    else if(zespolValue === "Vader") 
    {
    currentValue = basePrice * 1.4;
    } 
    else if(zespolValue === "Arch Enemy") 
    {
        currentValue = basePrice * 1.6;
    } 
    else 
    {
        alert("Wybierz zespół!");
        return -1;
    }

    const lokalizacja = document.getElementById('lokalizacja');
    const lokalizacjaValue = lokalizacja.options[lokalizacja.selectedIndex]?.text;

    if(lokalizacjaValue === "Warszawa") 
    {
        currentValue *= 2;
    } 
    else if(lokalizacjaValue === "Kraków") 
    {
        currentValue *= 1.8;
    } 
    else if(lokalizacjaValue === "Rzeszów") 
    {
        currentValue *= 1.4;
    } 
    else 
    {
        alert("Wybierz lokalizację!");
        return -1;
    }

    const sektor = document.getElementById('sektor');
    const sektorValue = sektor.options[sektor.selectedIndex]?.text;

    if (sektorValue === "Miejsca pod sceną") {
        currentValue *= 3;
    } else if (sektorValue === "Płyta") {
        currentValue *= 1.4;
    } else if (sektorValue === "Trybuny") {
        currentValue *= 1.2;
    } else {
        alert("Wybierz sektor!");
        return -1;
    }

    const kodPromocyjny = document.getElementById('kodPromocyjny').value.trim();

    if(kodPromocyjny == "Kod") 
    {
        currentValue *= 0.9; 
    }
    

    const resultValue = document.getElementById('resultValue');
    resultValue.textContent = `Cena: ${currentValue.toFixed(2)} zł`;
}




document.addEventListener("DOMContentLoaded", () =>{
    const countBtn = document.getElementById('count');
    const resetBtn = document.getElementById('reset');

    countBtn.addEventListener('click', () =>{
        valuePrint();
        priceCounter();
        })
    resetBtn.addEventListener('click', () =>{
        resetDropdowns();
        })
    })

