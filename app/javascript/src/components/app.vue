<template>
  <Header></Header>
  <router-view></router-view>
  {{ message }}
</template>

<script>
import { ref } from "vue";
import Header from "@/components/header.vue";

export default {
  name: "app",
  components: {
    Header,
  },
  setup() {
    const message = ref("Hello World");

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