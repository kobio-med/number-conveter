<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Number System Converter</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 20px;
      max-width: 600px;
    }
    h1 {
      text-align: center;
    }
    .conversion-row {
      margin-bottom: 10px;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 6px;
    }
    label {
      margin-right: 10px;
    }
    select, input[type="text"] {
      padding: 5px;
      margin-right: 10px;
      width: 120px;
    }
    button {
      padding: 10px 20px;
      margin-top: 15px;
      display: block;
      width: 100%;
      font-size: 16px;
    }
    .result {
      margin-top: 20px;
      padding: 10px;
      background: #f0f0f0;
      border-radius: 6px;
      white-space: pre-wrap;
      font-family: monospace;
    }
  </style>
</head>
<body>

  <h1>Number System Converter (Batch of 5)</h1>

  <div id="conversionContainer">
    <!-- Conversion rows will be injected here -->
  </div>

  <button onclick="performConversions()">Convert</button>

  <div class="result" id="result"></div>

  <script>
    const bases = ['bin', 'oct', 'dec', 'hex'];

    function createConversionRow(index) {
      return `
        <div class="conversion-row">
          <strong>Conversion ${index + 1}</strong><br />
          <label>Number:</label>
          <input type="text" id="num${index}" placeholder="Enter number" />
          <label>From:</label>
          <select id="fromBase${index}">
            ${bases.map(b => `<option value="${b}">${b.toUpperCase()}</option>`).join('')}
          </select>
          <label>To:</label>
          <select id="toBase${index}">
            ${bases.map(b => `<option value="${b}">${b.toUpperCase()}</option>`).join('')}
          </select>
        </div>
      `;
    }

    // Initialize 5 conversion rows
    const container = document.getElementById('conversionContainer');
    for (let i = 0; i < 5; i++) {
      container.innerHTML += createConversionRow(i);
    }

    // Helper: Convert base name to number
    function baseNameToNumber(baseName) {
      switch (baseName) {
        case 'bin': return 2;
        case 'oct': return 8;
        case 'dec': return 10;
        case 'hex': return 16;
        default: return null;
      }
    }

    function convertNumber(numStr, fromBase, toBase) {
      try {
        const decimalNum = parseInt(numStr, fromBase);
        if (isNaN(decimalNum)) throw new Error("Invalid number");

        if (toBase === 10) return decimalNum.toString();

        return decimalNum.toString(toBase).toUpperCase();
      } catch {
        return `Error: Invalid input "${numStr}" for base ${fromBase}`;
      }
    }

    function performConversions() {
      let results = 'Batch Conversion Results:\n\n';
      for (let i = 0; i < 5; i++) {
        const num = document.getElementById(`num${i}`).value.trim();
        const fromBaseName = document.getElementById(`fromBase${i}`).value;
        const toBaseName = document.getElementById(`toBase${i}`).value;

        if (!num) {
          results += `${i + 1}. No input provided\n`;
          continue;
        }

        const fromBase = baseNameToNumber(fromBaseName);
        const toBase = baseNameToNumber(toBaseName);

        const converted = convertNumber(num, fromBase, toBase);
        results += `${i + 1}. ${num} (${fromBaseName.toUpperCase()}) → ${converted} (${toBaseName.toUpperCase()})\n`;
      }

      document.getElementById('result').textContent = results;
    }
  </script>

</body>
</html>
