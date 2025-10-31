<script setup>
// Video background - no cleanup needed as it's in template
</script>


<template>
    <div class="relative text-white min-h-screen flex flex-col justify-between">
        <!-- Background Video -->
        <video 
            autoplay 
            loop 
            muted 
            playsinline
            class="fixed top-0 left-0 w-full h-full object-cover z-0"
            style="pointer-events: none;"
        >
            <source src="/images/hero_vid.mp4" type="video/mp4">
        </video>
        
        <!-- Content overlay -->
        <div class="relative z-10 flex flex-col justify-between min-h-screen">
            <div v-if="$route.name !== 'about'" class="flex justify-between items-center p-5 sticky top-0">
                <img class="w-28 md:w-28 lg:w-32 xl:w-36 max-w-full h-auto" src="/images/innercrkl.png" alt="Inner Circle" />
                <div class="about-button-wrapper">
                    <CustomButton @click="$router.push('/about')" text="About" />
                </div>
            </div>
            <div v-else class="w-full justify-between items-center flex py-2 pl-4 pr-20">
                <CustomButton @click="$router.push('/')" text="Home"/>
                <img src="/images/star2.png" class="h-6"/>
            </div>

            <div class="flex-1">
                <slot />
            </div>
        </div>
    </div> 
</template>

<style scoped>
.about-button-wrapper :deep(.silver-metallic-button) {
    width: 140px;
    height: 36px;
}

.about-button-wrapper :deep(.silver-metallic-button--medium) {
    height: 36px;
}

.about-button-wrapper :deep(.silver-metallic-button--medium .silver-metallic-button__bevel) {
    height: 34px;
}

.about-button-wrapper :deep(.silver-metallic-button--medium .silver-metallic-button__inner) {
    height: 30px;
    padding: 6px 16px;
}
</style>