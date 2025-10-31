<script setup lang="ts">
import { useUserStore } from '@/stores/genStore'
import { createClient } from '@supabase/supabase-js'
const $router = useRouter()

const config = useRuntimeConfig()
const supabase = createClient(
    config.public.supabaseUrl,
    config.public.supabaseAnonKey
);

const store = useUserStore()


definePageMeta({
    layout: 'step'
})

const currentStep = ref(1); // Start at the first step
const validationErrors = ref<string[]>([]);

// Validation functions for each step
const validateStep1 = () => {
    if (!store.user.name || store.user.name.trim() === '') {
        return 'Please enter your full name';
    }
    return null;
};

const validateStep3 = () => {
    if (!store.user.insta || store.user.insta.trim() === '') {
        return 'Please enter your Instagram handle';
    }
    return null;
};

const validateStep4 = () => {
    if (!store.user.email || store.user.email.trim() === '') {
        return 'Please enter your email address';
    }
    // Basic email validation
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(store.user.email)) {
        return 'Please enter a valid email address';
    }
    return null;
};

const nextStep = () => {
    let error = null;
    
    // Validate based on current step
    if (currentStep.value === 1) {
        error = validateStep1();
    } else if (currentStep.value === 3) {
        error = validateStep3();
    }
    
    if (error) {
        validationErrors.value = [error];
        return;
    }
    
    // Clear validation errors if validation passes
    validationErrors.value = [];
    
    if (currentStep.value < 4) {
        currentStep.value++;
    }
};

const handleLast = async () => {
    // Validate email before submission
    const error = validateStep4();
    if (error) {
        validationErrors.value = [error];
        return;
    }
    
    // Clear validation errors if validation passes
    validationErrors.value = [];
    
    // Submit form data without video upload
    try {
        const { error } = await supabase
            .from('users')
            .insert({
                name: store.user.name,
                gender: store.user.gender,
                insta: store.user.insta,
                email: store.user.email
            })
        
        if (error) {
            console.error('Error saving data:', error);
        } else {
            $router.push('/final');
        }
    } catch (error) {
        console.error('Error submitting form:', error);
    }
}


const handleGender = (gender: string) => {
    if (gender === 'Male') {
        store.user.gender = 'Guy'
    } else {
        store.user.gender = 'Babe'
    }
    currentStep.value++;
}

const prevStep = () => {
    if (currentStep.value > 1) {
        currentStep.value--;
    }
};

const stepClass = (index: number) => {
    if (index < currentStep.value) {
        return 'bg-[#c0bfc1]'; // Color for completed steps
    } else if (index === currentStep.value) {
        return 'bg-transparent'; // Transparent for current step (image will be shown)
    } else {
        return 'bg-[#202025]'; // Color for upcoming steps
    }
};

const isCurrentStep = (index: number) => {
    return index === currentStep.value;
};

// Clear validation errors when user starts typing
const clearValidationErrors = () => {
    if (validationErrors.value.length > 0) {
        validationErrors.value = [];
    }
};



</script>

<template>
    <div class="flex flex-col px-10 py-5 bg-black">
        <div v-show="currentStep === 1" class="flex space-y-4 flex-col">
            <div
                class="title bg-gradient-to-r from-[#FFFFFF] to-[#4C4B4B] mb-4 flex flex-col text-center text-transparent bg-clip-text text-3xl ">
                <span>What should we call you?</span>
            </div>
            <div class="text-center text-[#89898B] mb-2">
                <span>
                    Before we hit the road, let’s get familiar!
                </span>
            </div>
            <div class="w-full md:p-10">
                <InputField class="w-full mb-4" v-model="store.user.name" placeholder="Enter full name" @input="clearValidationErrors" />
                <!-- Validation error for step 1 -->
                <div v-if="validationErrors.length > 0 && currentStep === 1" class="text-yellow-400 text-sm mb-4 text-center">
                    {{ validationErrors[0] }}
                </div>
            <div class="w-full flex justify-center px-4">
                <CtaBtn @click="nextStep" text="Next"  />
            </div>
            </div>
          
            <div @click="$router.push('/')" class="text-center text-[#89898B]">
                <span>
                    Go back
                </span>
            </div>
        </div>
        <div v-show="currentStep === 2" class="flex space-y-4 flex-col">
            <div
                class="title bg-gradient-to-r from-[#FFFFFF] to-[#4C4B4B] mb-4 flex flex-col text-center text-transparent bg-clip-text text-3xl ">
                <span>What’s your gender?</span>
            </div>
            <div class="text-center text-[#89898B] mb-2">
                <span>
                    We are asking to ensure inclusion and <br /> tailor experiences for you
                </span>
            </div>
            <div class="flex flex-col space-y-3 md:flex-row md:space-x-4 md:space-y-0">
                <CtaBtn class="md:w-1/2" @click="handleGender('Male')" text="I'm a dawg" />
                <CtaBtn class="md:w-1/2" @click="handleGender('Female')" text="I'm a diva" />
            </div>
          

        </div>
        <div v-show="currentStep === 3" class="flex space-y-4 flex-col">
            <div
                class="title bg-gradient-to-r from-[#FFFFFF] to-[#4C4B4B] mb-4 flex flex-col text-center text-transparent bg-clip-text text-3xl ">
                <span>What’s your handle?</span>
            </div>
            <div class="text-center text-[#89898B] mb-2">
                <span>
                    We are not stalking, just getting <br /> a glimpse of your vibe
                </span>
            </div>
            <div class="w-full justify-center flex flex-col items-center px-4">
                <InputField class="w-full mb-4" v-model="store.user.insta" placeholder="Your Instagram @" @input="clearValidationErrors" />
                <!-- Validation error for step 3 -->
                <div v-if="validationErrors.length > 0 && currentStep === 3" class="text-yellow-400 text-sm mb-4 text-center">
                    {{ validationErrors[0] }}
                </div>

                <CtaBtn @click="nextStep" text="Next" class="w-fit"/>
            </div>
            <div @click="prevStep" class="text-center text-[#89898B]">
                <span>
                    Go back
                </span>
            </div>

        </div>
        <div v-show="currentStep === 4" class="flex space-y-4 flex-col">
            <div
                class="title bg-gradient-to-r from-[#FFFFFF] to-[#4C4B4B] mb-4 flex flex-col text-center text-transparent bg-clip-text text-3xl ">
                <span>Where do we send your invite?</span>
            </div>
            <div class="text-center text-[#89898B] mb-2">
                <span>
                    We promise, no spam, only the <br /> insider scoop!
                </span>
            </div>
            <InputField v-model="store.user.email" placeholder="Your email address" @input="clearValidationErrors" />
            <!-- Validation error for step 4 -->
                        <div v-if="validationErrors.length > 0 && currentStep === 4" class="text-yellow-400 text-sm mb-4 text-center">
                {{ validationErrors[0] }}
            </div>
            <div class="w-full justify-center flex max-w-sm px-4">
                <CtaBtn @click="handleLast" text="Submit" />
            </div>
            <div @click="prevStep" class="text-center text-[#89898B]">
                <span>
                    Go back
                </span>
            </div>

        </div>
        <div class="flex w-full bg-transparent justify-center space-x-5 mt-5">
            <div v-for="index in 4" :key="index" :class="stepClass(index)"
                class="rounded-full h-3 w-3 flex items-center justify-center">
                <img v-if="isCurrentStep(index)" src="/images/knob.png" class="rounded-full w-12 h-4"
                    alt="Current Step" />
            </div>
        </div>

        <footer class="text-center bg-transparent mt-5">
            <span class="text-xs text-center  footer-font text-[#d1cfd8]">Circle Ent. 2025</span>
        </footer>
    </div>


</template>

<style scoped>

</style>

