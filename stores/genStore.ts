import { defineStore } from 'pinia'


export const useUserStore = defineStore('user', () => {
    const user = {
      name: '',
      gender: '',
      insta: '',
      email: '',
      vid: '',
      eventType: ''
    }
  
    return { user }
  })