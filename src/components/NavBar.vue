<template>
  <div>
    <nav>
      <ul>
        <li v-for="nav in navigation" :key="nav">
          {{ nav }}
        </li>
      </ul>
    </nav>
  </div>
</template>

<script>
export default {
  data() {
    return {
      navigation: ["login", "dashboard"],
    };
  },
};
</script>

<style></style>
