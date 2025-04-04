<template>
  <search-bar :search-function="searchFunction"></search-bar>
  <data-table v-if="tableContents && tableContents.length > 0" :content="tableContents"></data-table>
  
</template>

<script>
import SearchBar from './components/SearchBar.vue';
import DataTable from './components/DataTable.vue';
import axios from 'axios';

export default {
  components: {
    SearchBar,
    DataTable
  },
  created() {
    this.loadData();
  },
  data() {
    return {
      tableContents: []
    }
  },
  methods: {
    async loadData() {
      const path = 'http://localhost:5001/items'
      axios.get(path).then((res) => {
        this.tableContents = res.data;
      }).catch((error) => {
        console.error(error);
      });
    },
    async searchFunction(searchField) {
      if (!searchField) {
        this.loadData();
        return;
      }
      const path = `http://localhost:5001/items/search:${this.formatSearchString(searchField)}`;
      axios.get(path).then((res) => {
        this.tableContents = res.data;
      }).catch((error) => {
        console.error(error);
      });
    },
    formatSearchString(string) {
      return string.normalize('NFD').replace(/[\u0300-\u036f]/g, '').replace(/[^a-zA-Z0-9]/g, '').toLowerCase();
    }
  }
}
</script>