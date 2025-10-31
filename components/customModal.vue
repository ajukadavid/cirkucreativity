<template>
    <div v-if="isVisible" class="modal-overlay" @click.self="closeModal">
      <div class="modal-content">
        <slot></slot>
      </div>
    </div>
  </template>
  
  <script>
  export default {
    props: {
      isVisible: {
        type: Boolean,
        required: true
      }
    },
    methods: {
      closeModal() {
        this.$emit('update:isVisible', false);
      }
    }
  }
  </script>
  
  <style scoped>
  .modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.5);
    display: flex;
    justify-content: center;
    align-items: center;
  }
  .modal-content {
    background: black;
    
    border: 1px solid #2C2C2C;
    padding: 20px;
    border-radius: 12px;
    position: relative;
  }
  .close-button {
    position: absolute;
    top: 10px;
    right: 10px;
  }
  </style>