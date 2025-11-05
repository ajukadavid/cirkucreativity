<script setup lang="ts">
import { useUserStore } from '@/stores/genStore'
import { createClient } from '@supabase/supabase-js'

const store = useUserStore()
const router = useRouter()
const isLoading = ref(false)

const config = useRuntimeConfig()
const supabase = createClient(
    config.public.supabaseUrl,
    config.public.supabaseAnonKey
);

const handlePayment = async () => {
    isLoading.value = true;
    
    // Here you would integrate with your payment provider (Paystack, Stripe, etc.)
    // For now, we'll save the data and redirect to final page
    
    try {
        // Save user data to database
        const { error } = await supabase
            .from('users')
            .insert({
                name: store.user.name,
                gender: store.user.gender,
                insta: store.user.insta,
                email: store.user.email,
                eventType: store.user.eventType
            })
        
        if (error) {
            console.error('Error saving data:', error);
            isLoading.value = false;
            return;
        }
        
        // TODO: Integrate actual payment processing here
        // For now, simulate payment success and redirect
        
        setTimeout(() => {
            router.push('/final');
        }, 1000);
        
    } catch (error) {
        console.error('Error processing payment:', error);
        isLoading.value = false;
    }
};

const getEventTypeLabel = () => {
    const eventTypes: Record<string, string> = {
        'texture-art': 'Texture Art',
        'wood-epoxy': 'Wood works with epoxy',
        'rug-tufting': 'Rug Tufting'
    };
    return eventTypes[store.user.eventType] || store.user.eventType;
};
</script>

<template>
    <div class="flex flex-col px-4 md:px-10 py-5 min-h-screen">
        <div class="flex flex-col items-center max-w-2xl mx-auto w-full space-y-6">
            <div class="title mb-4 flex flex-col text-center text-3xl">
                <span>Complete Payment</span>
            </div>
            
            <div class="text-center mb-6">
                <span>
                    Review your details and proceed with payment
                </span>
            </div>

            <!-- Reservation Summary -->
            <div class="w-full border-2 border-white p-6 bg-transparent space-y-3">
                <div>
                    <span class="font-semibold">Event Type:</span>
                    <span class="ml-2">{{ getEventTypeLabel() }}</span>
                </div>
                <div>
                    <span class="font-semibold">Name:</span>
                    <span class="ml-2">{{ store.user.name }}</span>
                </div>
                <div>
                    <span class="font-semibold">Email:</span>
                    <span class="ml-2">{{ store.user.email }}</span>
                </div>
            </div>

            <!-- Payment Amount -->
            <div class="w-full text-center">
                <div class="title text-2xl mb-2">
                    <span>Total Amount</span>
                </div>
                <div class="text-3xl font-bold">
                    <!-- TODO: Add actual pricing logic -->
                    <span>₦0.00</span>
                </div>
            </div>

            <!-- Payment Button -->
            <div class="w-full flex justify-center mt-6">
                <CtaBtn 
                    @click="handlePayment" 
                    :disabled="isLoading"
                    :text="isLoading ? 'Processing...' : 'Complete Payment'" 
                />
            </div>

            <!-- Go Back -->
            <div @click="router.push('/details')" class="text-center cursor-pointer">
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

