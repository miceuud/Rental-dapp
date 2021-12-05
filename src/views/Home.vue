<template>
  <div class="home">
    <b-navbar>
      <b-nav-item @click="signIn">
        {{ loginUser || " Sign in with metamask" }}
      </b-nav-item>
      <!-- v-if="loginUser" -->
      <b-nav-item>
        <b-link to="dashboard">dashboard</b-link>
      </b-nav-item>
    </b-navbar>

    <h2>Car rental service</h2>
    <p>
      Lorem ipsum dolor sit amet consectetur adipisicing elit. Incidunt, harum
      quidem illum eveniet eligendi earum iusto repudiandae eaque molestias
      molestiae ducimus architecto quae ut eum ratione deleniti omnis culpa
      maxime!
    </p>
    <car-list @userLoggedIn="userLoggedIn" />
  </div>
</template>

<script>
// @ is an alias to /src
import CarList from "../components/CarList.vue";

export default {
  name: "Home",
  components: {
    CarList,
  },
  data() {
    return {
      loginUser: "",
    };
  },
  methods: {
    // passed from child component
    userLoggedIn(account) {
      this.loginUser = account;
    },
    async signIn() {
      if (typeof window.ethereum === "undefined") {
        console.log("please installed metamask");
        this.installedWallet = true;
      }

      let result = await window.ethereum.request({
        method: "eth_requestAccounts",
      });
      this.loginUser = result[0];
    },
  },
};
</script>
<style scoped>
li {
  list-style: none;
}
li a {
  text-decoration: none;
}
</style>
