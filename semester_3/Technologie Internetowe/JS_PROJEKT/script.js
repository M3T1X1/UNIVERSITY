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


    const resultElement = document.getElementById('result');
    resultElement.textContent = `Twoje wybory: ${zespolValue},  ${lokalizacjaValue}, ${sektorValue}`;
}

document.addEventListener("DOMContentLoaded", () =>{
    const countBtn = document.getElementById('count');
    const resetBtn = document.getElementById('reset');

    countBtn.addEventListener('click', () =>{
        valuePrint();
        })
    resetBtn.addEventListener('click', () =>{
        resetDropdowns();
        })
    })

