<template>
  <div id="app">
    <div id="nav">
      <div>
        <router-link class="main-home" to="/">Rentals Speciale</router-link>
      </div>
    </div>

    <router-view />
  </div>
</template>

<script>
export default {
  data() {
    return {};
  },
  components: {},
  methods: {},
};
</script>

<style>
@import url("https://fonts.googleapis.com/css2?family=Comforter+Brush&display=swap");
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
}
</style>
