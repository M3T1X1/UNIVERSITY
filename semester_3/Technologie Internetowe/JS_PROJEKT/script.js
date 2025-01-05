function resetDropdowns() {
    const dropdowns = document.querySelectorAll('select');
    dropdowns.forEach(dropdown => dropdown.selectedIndex = 0);
}
