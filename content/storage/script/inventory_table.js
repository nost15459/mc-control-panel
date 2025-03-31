async function draw_table() {
    const inventory = await fetchInventory();
    const container = document.getElementById("table-container");

    //re-create the whole table -> todo: implement partial update
    const table = document.createElement("table");
    
    if (Object.keys(inventory).length === 0) {
        // inventory is empty object
        container.innerHTML = "ME storage is empty, or no inventory data is available"
        return;
    }

    const header = table.insertRow();
    ["アイテム", "在庫数"].forEach((col) => {
        const th = document.createElement("th");
        th.textContent = col;
        header.appendChild(th);
    });

    inventory.forEach((item, _) => {
        const row = table.insertRow();
        row.insertCell().textContent = item.displayName;
        row.insertCell().textContent = item.amount;
    });

    container.innerHTML = ""; // clear table
    container.appendChild(table)
}


async function fetchInventory() {
    const response = await fetch("/api/me-inventory/fetch-inventory");
    return await response.json();
}

//1000ms
setInterval(draw_table, 1000)
draw_table();
