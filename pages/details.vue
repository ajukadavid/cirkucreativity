<script setup lang="ts">
import { useUserStore } from '@/stores/genStore'

const store = useUserStore()
const router = useRouter()
const validationErrors = ref<string[]>([]);

const validateForm = () => {
    const errors: string[] = [];
    
    if (!store.user.name || store.user.name.trim() === '') {
        errors.push('Please enter your full name');
    }
    
    if (!store.user.gender || store.user.gender.trim() === '') {
        errors.push('Please select your gender');
    }
    
    if (!store.user.email || store.user.email.trim() === '') {
        errors.push('Please enter your email address');
    } else {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(store.user.email)) {
            errors.push('Please enter a valid email address');
        }
    }
    
    return errors;
};

const handleGender = (gender: string) => {
    if (gender === 'Male') {
        store.user.gender = 'Guy'
    } else {
        store.user.gender = 'Babe'
    }
};

const submitForm = () => {
    validationErrors.value = [];
    const errors = validateForm();
    
    if (errors.length > 0) {
        validationErrors.value = errors;
        return;
    }
    
    // Navigate to payment page
    router.push('/payment');
};

const clearValidationErrors = () => {
    if (validationErrors.value.length > 0) {
        validationErrors.value = [];
    }
};
</script>

<template>
    <div class="flex flex-col px-4 md:px-10 py-5 min-h-screen">
        <div class="flex flex-col items-center max-w-2xl mx-auto w-full space-y-6">
            <div class="title mb-4 flex flex-col text-center text-3xl">
                <span>Your Details</span>
            </div>
            
            <div class="text-center mb-6">
                <span>
                    We need a few details to complete your reservation
                </span>
            </div>

            <!-- Validation errors -->
            <div v-if="validationErrors.length > 0" class="w-full space-y-2 mb-4">
                <div 
                    v-for="(error, index) in validationErrors" 
                    :key="index"
                    class="text-sm text-center"
                >
                    {{ error }}
                </div>
            </div>

            <!-- Full Name -->
            <div class="w-full">
                <label class="block mb-2 text-sm font-semibold">Full Name</label>
                <InputField 
                    class="w-full" 
                    v-model="store.user.name" 
                    placeholder="Enter your full name" 
                    @input="clearValidationErrors" 
                />
            </div>

            <!-- Gender -->
            <div class="w-full">
                <label class="block mb-3 text-sm font-semibold">Gender</label>
                <div class="flex flex-col space-y-3 md:flex-row md:space-x-4 md:space-y-0">
                    <CtaBtn 
                        class="md:w-1/2" 
                        @click="handleGender('Male')" 
                        text="Male" 
                    />
                    <CtaBtn 
                        class="md:w-1/2" 
                        @click="handleGender('Female')" 
                        text="Female" 
                    />
                </div>
            </div>

    
            <!-- Email -->
            <div class="w-full">
                <label class="block mb-2 text-sm font-semibold">Email Address</label>
                <InputField 
                    class="w-full" 
                    v-model="store.user.email" 
                    placeholder="your.email@example.com" 
                    @input="clearValidationErrors" 
                />
            </div>

            <!-- Submit Button -->
            <div class="w-full flex justify-center mt-6">
                <CtaBtn @click="submitForm" text="Proceed to Payment" />
            </div>

            <!-- Go Back -->
            <div @click="router.push('/collect')" class="text-center cursor-pointer">
                <span>Go back</span>
            </div>
        </div>

        <footer class="text-center bg-transparent mt-10">
            <span class="text-xs text-center footer-font">Circle Ent. 2025</span>
        </footer>
    </div>
</template>

<style scoped>
</style>

