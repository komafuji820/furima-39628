function calcTax(price){
  const tax = 0.1
  return Math.floor(price * tax)
};

function calcProfit(price){
  const profit = price - calcTax(price)
  return Math.floor(profit)
};

const inputPrice = document.getElementById('item-price');
const taxPrice = document.getElementById('add-tax-price');
const profit = document.getElementById('profit');

inputPrice.addEventListener('input', () => {
  const price = inputPrice.value
  taxPrice.innerHTML = calcTax(price)
  profit.innerHTML = calcProfit(price)
});