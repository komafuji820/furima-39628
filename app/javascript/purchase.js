const calcTax = (price) => {
  const tax = 0.1;
  return Math.floor(price * tax);
};

const calcProfit = (price) => {
  const profit = price - calcTax(price);
  return Math.floor(profit);
};

const purchase = () => {
  
  const itemPrice = document.getElementById('item-price');
  
  itemPrice.addEventListener('input', () => {
    const price = itemPrice.value;

    const taxPrice = document.getElementById('add-tax-price');
    const profit = document.getElementById('profit');
    
    taxPrice.innerHTML = calcTax(price);
    profit.innerHTML = calcProfit(price);
  });
}

window.addEventListener('turbo:load', purchase);
window.addEventListener('turbo:render', purchase);