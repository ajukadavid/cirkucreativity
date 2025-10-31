<<script setup>


const currentIndex = ref(0);
const loadingWidth = ref('0%');
const router = useRouter();

const startLoading = () => {
  currentIndex.value++;
  let progress = 0;

  const interval = setInterval(() => {
    progress += 1; 
    loadingWidth.value = `${progress}%`;

    if (progress >= 100) {
      clearInterval(interval); 
      router.push({ name: 'flow' });
    }
  }, 10);
};
</script>

<template>
    <div class="h-screen main flex flex-col space-y-12 items-center justify-center">
        <div class="flex items-center justify-center flex-col px-8 space-y-5">
            <div v-if="currentIndex === 0" class="flex space-y-5 flex-col">

                <div
                    class="title bg-gradient-to-r from-[#FFFFFF] to-[#4C4B4B] mb-4 flex flex-col text-center text-transparent bg-clip-text text-3xl ">
                    <span>No More Way <br />For Poor People</span>
                </div>

                <div class="text-center text-[#89898B]">
                    <span>
                        Inner circle and KRL invites you to the Exclusive Mavo Kilometer II Experience
                    </span>
                </div>
                <div class="w-full flex justify-center">
                    <CtaBtn @click="startLoading" text="Get Bizzy" />
                </div>
                <div class="text-center text-[#89898B]">
                    <span>
                       Exit
                    </span>
                </div>
            </div>
            <div  class="flex flex-col space-y-3" v-if="currentIndex === 1">
                <div class="loading-container">

                <div
                    class="title bg-gradient-to-r from-[#FFFFFF] to-[#4C4B4B] mb-4 flex flex-col text-center text-transparent bg-clip-text text-3xl ">
                    <span>Awesome</span>
                </div>

                <div class="text-center text-[#89898B]">
                    <span>
                        Grab your seat belt. Your journey on an exclusive experience begins now!
                    </span>
                </div>
                    <div class="loading-bar mt-4">
                        <div class="loading-fill" :style="{ width: loadingWidth }"></div>
                    </div>
             </div>
            </div>

        </div>
        <footer class="text-center bg-transparent mt-5">
            <span class="text-xs text-center  footer-font text-[#d1cfd8]">Circle Ent. 2025</span>
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

</style>

