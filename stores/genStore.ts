import { defineStore } from 'pinia'


export const useUserStore = defineStore('user', () => {
    const user = {
      name: '',
      email: '',
      phone: '',
      eventType: '',
      session: '',
      designImage: null as File | null,
      consent: false
    }
  
    return { user }
  })