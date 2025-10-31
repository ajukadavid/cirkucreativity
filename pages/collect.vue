<script setup>
import { useUserStore } from '@/stores/genStore'

const store = useUserStore()

const currentIndex = ref(0);
const loadingWidth = ref('0%');
const router = useRouter();
const showEventSelection = ref(true); // Show event selection immediately

const eventTypes = [
  { value: 'texture-art', label: 'Texture Art', capacity: '20 guests' },
  { value: 'wood-epoxy', label: 'Wood works with epoxy', capacity: '20 guests' },
  { value: 'rug-tufting', label: 'Rug Tufting', capacity: '10 guests' }
];

const selectEventType = () => {
  if (!store.user.eventType) {
    return; // Don't proceed without selection
  }
  showEventSelection.value = false;
  startLoading();
};

const startLoading = () => {
  currentIndex.value++;
  let progress = 0;

  const interval = setInterval(() => {
    progress += 1; 
    loadingWidth.value = `${progress}%`;

    if (progress >= 100) {
      clearInterval(interval); 
      router.push({ name: 'details' });
    }
  }, 10);
};

const handleGetStarted = () => {
  showEventSelection.value = true;
};
</script>

<template>
    <div class="h-screen main flex flex-col space-y-12 items-center justify-center">
        <div class="flex items-center justify-center flex-col px-8 space-y-5">
            <div v-if="currentIndex === 0 && !showEventSelection" class="flex space-y-5 flex-col">

                <div
                    class="title mb-4 flex flex-col text-center text-3xl ">
                    <span>Welcome to <br />CIRku</span>
                </div>

                <div class="text-center">
                    <span>
                        Join us for a DIY creative experience where art, craft, and community come together
                    </span>
                </div>
                <div class="w-full flex justify-center">
                    <CtaBtn @click="handleGetStarted" text="Get Started" />
                </div>
                <div class="text-center">
                    <span>
                       Exit
                    </span>
                </div>
            </div>

            <div v-if="showEventSelection && currentIndex === 0" class="flex space-y-5 flex-col max-w-md w-full">
                <div
                    class="title mb-4 flex flex-col text-center text-3xl ">
                    <span>Choose Your <br />Experience</span>
                </div>

                <div class="text-center mb-4">
                    <span>
                        Select the creative activity you'd like to participate in
                    </span>
                </div>

                <div class="w-full">
                    <select 
                        v-model="store.user.eventType"
                        class="event-type-select w-full"
                    >
                        <option value="" disabled>Select an event type</option>
                        <option 
                            v-for="event in eventTypes" 
                            :key="event.value" 
                            :value="event.value"
                        >
                            {{ event.label }} ({{ event.capacity }})
                        </option>
                    </select>
                </div>

                <div class="w-full flex justify-center">
                    <CtaBtn 
                        @click="selectEventType" 
                        :disabled="!store.user.eventType"
                        text="Continue" 
                    />
                </div>
                
                <div @click="$router.push('/')" class="text-center cursor-pointer">
                    <span>Go back</span>
                </div>
            </div>
            <div  class="flex flex-col space-y-3" v-if="currentIndex === 1">
                <div class="loading-container">

                <div
                    class="title mb-4 flex flex-col text-center text-3xl ">
                    <span>Awesome</span>
                </div>

                <div class="text-center">
                    <span>
                        Get ready to create! Your creative journey begins now.
                    </span>
                </div>
                    <div class="loading-bar mt-4">
                        <div class="loading-fill" :style="{ width: loadingWidth }"></div>
                    </div>
             </div>
            </div>

        </div>
        <footer class="text-center bg-transparent mt-5">
            <span class="text-xs text-center footer-font">Circle Ent. 2025</span>
        </footer>
    </div>
</template>

<style scoped>
.loading-container {
  padding: 20px;
  width: 100%;
}

.loading-bar {
  position: relative;
  width: 100%;
  height: 8px;
  border-radius: 15px;
  background: #eee;
  overflow: hidden;
}

.loading-fill {
  position: absolute;
  height: 100%;
  background: linear-gradient(90deg, #D7D8D4 0%, #A8A9AD 50%, #8A8A8A 100%);
  border: 1px solid #A2A2A2;
  box-shadow: inset 0 1px 0 #CFCFCF;
  border-radius: 15px;
  transition: width 0.5s ease-in-out;
}

.event-type-select {
  padding: 12px 16px;
  border: 2px solid #000000;
  border-radius: 0;
  background: #FFFFFF;
  color: #000000;
  font-size: 16px;
  font-family: 'InterFont', sans-serif;
  cursor: pointer;
  outline: none;
  appearance: none;
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23000000' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
  background-repeat: no-repeat;
  background-position: right 16px center;
  padding-right: 40px;
}

.event-type-select:focus {
  outline: none;
}

.event-type-select option {
  background: #FFFFFF;
  color: #000000;
  padding: 10px;
}

</style>

