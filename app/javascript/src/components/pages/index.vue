<template>
  <!-- 新規作成部分 -->
  <div class="row">
    <div class="col s10 m11">
      <input
        v-model="newTask"
        class="form-control"
        placeholder="Add your task!!"
      />
    </div>
    <div class="col s2 m1">
      <div
        @click="createTask"
        class="btn-floating waves-effect waves-light red"
      >
        <i class="material-icons">add</i>
      </div>
    </div>
  </div>
  <!-- リスト表示部分 -->
  <div>
    <ul class="collection">
      <li
        v-for="task in tasks"
        :key="task.id"
        :v-if="!task.is_done"
        v-bind:id="'row_task_' + task.id"
        class="collection-item"
      >
        <input
          type="checkbox"
          @change="doneTask(task.id)"
          :id="'task_' + task.id"
        />
        <label v-bind:for="'task_' + task.id">{{ task.name }}</label>
      </li>
    </ul>
  </div>
  <!-- 完了済みタスク表示ボタン -->
  <div class="btn" v-on:click="displayFinishedTasks">
    Display finished tasks
  </div>
  <!-- 完了済みタスク一覧 -->
  <div id="finished-tasks" class="display_none">
    <ul class="collection">
      <li id="row_task_4" class="collection-item"></li>
      <li
        v-for="task in tasks"
        :key="task.id"
        :v-if="task.is_done"
        v-bind:id="'row_task_' + task.id"
        class="collection-item"
      >
        <input
          type="checkbox"
          v-bind:id="'task_' + task.id"
          checked="checked"
        />
        <label v-bind:for="'task_' + task.id" class="line-through">{{
          task.name
        }}</label>
      </li>
    </ul>
  </div>
</template>

<script>
import { ref, onMounted } from "vue";
import axios from "axios";

export default {
  setup() {
    const tasks = ref([]);

    const fetchTasks = () => {
      axios.get("/api/tasks").then(
        (response) => {
          for (var i = 0; i < response.data.tasks.length; i++) {
            tasks.value.push(response.data.tasks[i]);
          }
        },
        (error) => {
          console.log(error);
        }
      );
    };

    onMounted(() => {
      fetchTasks();
    });

    const newTask = ref("");
    const createTask = () => {
      if (!newTask.value) return;

      axios.post("/api/tasks", { task: { name: newTask.value } }).then(
        (response) => {
          tasks.value.unshift(response.data.task);
          newTask.value = "";
        },
        (error) => {
          console.log(error);
        }
      );
    };
    const doneTask = (task_id) => {
      axios.put("/api/tasks/" + task_id, { task: { is_done: 1 } }).then(
        (response) => {
          moveFinishedTask(task_id);
        },
        (error) => {
          console.log(error);
        }
      );
    };
    const moveFinishedTask = (task_id) => {
      var el = document.querySelector("#row_task_" + task_id);
      // DOMをクローンしておく
      var el_clone = el.cloneNode(true);
      // 未完了の方を先に非表示にする
      el.classList.add("display_none");
      // もろもろスタイルなどをたして完了済みに追加
      el_clone.getElementsByTagName("input")[0].checked = "checked";
      el_clone.getElementsByTagName("label")[0].classList.add("line-through");
      el_clone
        .getElementsByTagName("label")[0]
        .classList.remove("word-color-black");
      var li = document.querySelector("#finished-tasks > ul > li:first-child");
      document.querySelector("#finished-tasks > ul").insertBefore(el_clone, li);
    };

    const displayFinishedTasks = () => {
      document
        .querySelector("#finished-tasks")
        .classList.toggle("display_none");
    };

    return {
      tasks,
      newTask,
      createTask,
      displayFinishedTasks,
      doneTask,
    };
  },
};
</script>

 <style scoped>
[v-cloak] {
  display: none;
}
.display_none {
  display: none;
}
/* 打ち消し線を引く */
.line-through {
  text-decoration: line-through;
}
</style>