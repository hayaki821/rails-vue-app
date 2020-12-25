<template>
  <p>
    {{ message }}
  </p>
</template>

<script>
import { ref } from "vue";

export default {
  name: "Hello",
  setup() {
    const message = ref("Hell World");

    return {
      message,
    };
  },
};
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
