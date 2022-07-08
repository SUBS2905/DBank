import {dbank} from "../../declarations/dbank";

//After the webpage has finished loading we await the call of checkBalance() to complete and update the HTML
window.addEventListener("load", async ()=>{
  update();
});

document.querySelector("form").addEventListener("submit", async (event)=>{
  event.preventDefault();
  const button = event.target.querySelector("#submit-btn");

  const inputAmount = parseFloat(document.getElementById("input-amount").value);
  const outputAmount = parseFloat(document.getElementById("withdrawal-amount").value);

  button.setAttribute("disabled", true);

  if(document.getElementById("input-amount").value.length != 0){
    await dbank.topUp(inputAmount);
    document.getElementById("input-amount").value = "";
  }

  else if(document.getElementById("withdrawal-amount").value.length != 0){
    await dbank.withdraw(outputAmount);
    document.getElementById("withdrawal-amount").value = "";
  }

  await dbank.compound();

  update();
  
  button.removeAttribute("disabled");

});

async function update(){
  const currentAmount = await dbank.checkBalance();
  document.querySelector("#value").innerText = Math.round(currentAmount*100)/100;
};