<template>
  <div class="listing">
    <p v-if="installedWallet">Please install Metamask</p>

    <b-container class="bv-example-row mb-3">
      <b-row cols="4" class="description">
        <b-col v-for="(car, index) in cars" :key="index" class="card selected">
          <img
            :src="require('../assets/' + car.image)"
            alt="rental-cars"
            class="car-image"
          />

          <span>{{ car.name }}</span>
          <span>{{ car.vin }}</span>
          <!-- <span>{{index}}</span> -->
          <button type="submit" v-if="!car.rented" @click.prevent="rent(index)">
            Rent
          </button>
          <!-- check this -->
          <button @click="returnRental(index)">Return</button>
          <!-- <div>
          
        </div> -->
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>

<script>
import { ethers } from "ethers";
import Rental from "../artifacts/contracts/Rental.sol/Rental.json";
export default {
  data() {
    return {
      cars: [
        {
          name: "mercedes",
          year: "2021",
          vin: "vin12345",
          rented: false,
          available: true,
          image: "bettle-car.jpeg",
          renter: "",
        },
        {
          name: "toyoto yarris",
          year: "2021",
          vin: "vin-1234",
          rented: false,
          available: true,
          image: "bettle-car.jpeg",
          renter: "",
        },
        {
          name: "ford arinzo",
          year: "2021",
          vin: "vin12345",
          rented: false,
          available: true,
          image: "bettle-car.jpeg",
          renter: "",
        },
        {
          name: "avensis",
          year: "2021",
          vin: "vin123wdd",
          rented: false,
          available: true,
          image: "bettle-car.jpeg",
          renter: "",
        },
        {
          name: "ford aviento",
          year: "2021",
          vin: "vin109095",
          rented: false,
          available: true,
          image: "bettle-car.jpeg",
          renter: "",
        },
        {
          name: "mercedes glk",
          year: "1989",
          vin: "vin1345",
          rented: false,
          available: true,
          image: "bettle-car.jpeg",
          renter: "",
        },
        {
          name: "toyoto maxass",
          year: "2021",
          vin: "vin-1234",
          rented: false,
          available: true,
          image: "bettle-car.jpeg",
          renter: "",
        },
        {
          name: "ford chill",
          year: "2021",
          vin: "vin12345",
          rented: false,
          available: true,
          image: "bettle-car.jpeg",
          renter: "",
        },
        {
          name: "avsis",
          year: "2021",
          vin: "vin123wdd",
          rented: false,
          available: true,
          image: "bettle-car.jpeg",
          renter: "",
        },
        {
          name: "ford avito",
          year: "2021",
          vin: "vin109095",
          rented: false,
          available: true,
          image: "bettle-car.jpeg",
          renter: "",
        },
      ],
      installedWallet: false,
      account: " ",
      contractAddress: "0xc6e7DF5E7b4f2A278906862b61205850344D4e7d",
      // rented:""
    };
  },
  methods: {
    async rent(index) {
      // check for wallet
      if (typeof window.ethereum === "undefined") {
        console.log("please installed metamask");
        this.installedWallet = true;
      }
      // connect to a wallet account
      let result = await window.ethereum.request({
        method: "eth_requestAccounts",
      });
      this.account = result[0];
      // emited to parent component
      this.$emit("userLoggedIn", this.account);
      if (
        this.cars[index].rented === true &&
        this.cars[index].available === false
      ) {
        console.log(this.cars[index].name + " is not available");
        return;
      }

      const contractAddress = "0x9A9f2CCfdE556A7E9Ff0848998Aa4a0CFD8863AE";
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();

      const RentalContract = new ethers.Contract(
        contractAddress,
        Rental.abi,
        signer
      );
      let rental = await RentalContract.requestARental(index, this.account);
      // process smart contract response below
      console.log(rental);
      this.cars[index].rented = true;
      this.cars[index].available = false;
      this.cars[index].renter = this.account;

      console.log(
        this.cars[index].available,
        this.cars[index].rented,
        `this car is rented by ${this.cars[index].renter} `
      );
      // console.log(this.cars[index].);
    },
    async returnRental(index) {
      console.log(index);

      // check for wallet
      if (typeof window.ethereum === "undefined") {
        console.log("please installed metamask");
        this.installedWallet = true;
      }
      // connect to a wallet account
      let result = await window.ethereum.request({
        method: "eth_requestAccounts",
      });
      this.account = result[0];
      // emited to parent component
      this.$emit("userLoggedIn", this.account);

      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();

      const RentalContract = new ethers.Contract(
        this.contractAddress,
        Rental.abi,
        signer
      );
      let rental = await RentalContract.returnRental(index, this.account);
      // process smart contract response below
      console.log(rental);
      this.cars[index].rented = false;
      this.cars[index].available = true;
      this.cars[index].renter = "";

      console.log(
        this.cars[index].available,
        this.cars[index].rented,
        `this car has been returned by`
      );

      // returnRental
    },
  },
};
</script>

<style>
/* .description {
  display: flex;
  flex-wrap: wrap;
} */

/* .card {
  margin: 10px 10px;
} */
.car-image {
  /* widows: 120px;
  height: 120px; */
  display: block;
}
/* .selected {
  margin: 10px 10px;
} */
/* button {
  border: 1px solid black;
  display: block;
  padding: 4px 8px;
  border-radius: 5px;
} */
/* span {
  display: block;
} */
</style>
