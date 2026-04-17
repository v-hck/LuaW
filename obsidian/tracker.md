```dataviewjs
const pages = dv.pages().where(p => p.file.tasks.length && !p.file.path.match(/\.t\.md$/));
const tasks = pages.file.tasks.array().flat();
const total = tasks.length;
const completed = tasks.filter(t => t.completed).length;
const percent = total ? Math.round(completed / total * 100) : 0;

// Построение дерева папок
const root = { total: 0, done: 0, subdirs: new Map(), files: [] };

for (const page of pages) {
    const parts = page.file.folder.split('/').filter(p => p);
    let node = root;
    const fileTotal = page.file.tasks.length;
    const fileDone = page.file.tasks.filter(t => t.completed).length;
    root.total += fileTotal;
    root.done += fileDone;

    for (let i = 0; i < parts.length; i++) {
        const folderName = parts[i];
        if (!node.subdirs.has(folderName)) {
            node.subdirs.set(folderName, { total: 0, done: 0, subdirs: new Map(), files: [] });
        }
        node = node.subdirs.get(folderName);
        node.total += fileTotal;
        node.done += fileDone;
    }
    node.files.push({
        name: page.file.name,
        total: fileTotal,
        done: fileDone
    });
}

// Рекурсивная отрисовка дерева
function renderTree(node, name = 'Общий прогресс:', level = 0) {
    const indent = ' '.repeat(level);
    const percent = node.total ? Math.round(node.done / node.total * 100) : 0;
    const progressBar = `<progress value="${percent}" max="100" style="width:120px;"></progress> ${node.done}/${node.total} (${percent}%)`;
    
    let html = `<div>${indent}${level === 0 ? '📂' : '📁'} ${name} ${progressBar}</div>`;
    
    for (const [subName, subNode] of node.subdirs.entries()) {
        html += renderTree(subNode, subName, level + 1);
    }
    
    for (const file of node.files) {
        const fPercent = file.total ? Math.round(file.done / file.total * 100) : 0;
        const fBar = `<progress value="${fPercent}" max="100" style="width:100px;"></progress> ${file.done}/${file.total}`;
        html += `<div>${indent} 📄 ${file.name} ${fBar}</div>`;
    }
    
    return html;
}

const treeContainer = this.container.createEl('div');
treeContainer.innerHTML = renderTree(root);

// Гистограмма по файлам (без .t.md)
const fileStats = pages.map(p => {
    const total = p.file.tasks.length;
    const done = p.file.tasks.filter(t => t.completed).length;
    return { name: p.file.name, total, done, left: total - done };
}).array();

if (fileStats.length) {
    const barDiv = this.container.createEl('div', { attr: { style: 'height:300px; width:100%; margin-top:20px;' } });
    window.renderChart({
        type: 'bar',
        data: {
            labels: fileStats.map(f => f.name),
            datasets: [
                { label: 'Выполнено', data: fileStats.map(f => f.done), backgroundColor: '#2ecc71' },
                { label: 'Осталось', data: fileStats.map(f => f.left), backgroundColor: '#e74c3c' }
            ]
        },
        options: {
            indexAxis: 'y',
            maintainAspectRatio: false,
            scales: { x: { stacked: true }, y: { stacked: true } }
        }
    }, barDiv);
}
```
