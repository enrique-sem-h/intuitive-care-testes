<template>
  <div class="d-flex justify-content-center align-items-start mt-5">
    <div class="input-group" style="width: 400px;">
      <input type="search" class="form-control" placeholder="Registro, cnpj, nome..." v-model="searchField">
      <button class="btn btn-primary" @click.prevent="click">
        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search"
          viewBox="0 0 16 16">
          <path
            d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0" />
        </svg>
      </button>
    </div>
  </div>
</template>

<script>
export default {
  props: ['searchFunction'],
  data() {
    return {
      searchField: '',
    }
  },
  methods: {
    click() {
      this.searchFunction(this.searchField);
      this.searchField = '';
    }
  }
}
</script>