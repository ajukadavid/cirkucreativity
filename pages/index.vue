<script setup lang="ts">
import { useUserStore } from '@/stores/genStore'
import { createClient } from '@supabase/supabase-js'

const store = useUserStore()
const router = useRouter()
const config = useRuntimeConfig()

const showBookingForm = ref(false)
const validationErrors = ref<string[]>([])
const isLoading = ref(false)
const fileInputRef = ref<HTMLInputElement | null>(null)
const previewImage = ref<string | null>(null)

const workshops = [
  {
    id: 'rug-tufting',
    name: 'Rug Tufting',
    capacity: '10 guests',
    price: 100000,
    description: 'Create beautiful hand-tufted rugs with personalized designs. Learn the art of tufting and take home your own custom rug masterpiece.',
    image: '/images/rug.jpeg'
  },
  {
    id: 'texture-art',
    name: 'Texture Art',
    capacity: '20 guests',
    price: 100000,
    description: 'Explore the world of texture and dimension. Create stunning textured art pieces using plaster and various techniques.',
    image: '/images/chess.jpeg'
  },
  {
    id: 'resin-art',
    name: 'Resin Art Workshop',
    capacity: '15 guests',
    price: 100000,
    description: '4 Hours of Liquid Imagination. Step into the glossy world of resin art — where color, depth, and design flow together. Under the guidance of TheResinWorld, participants learn to mix, tint, and pour resin to create beautiful functional or decorative pieces.',
    details: {
      beforeClass: [
        'Participants must select their project type and send their color palette or inspiration reference at least 3 days before the workshop.',
        'The team will prepare the molds and pigments ahead of time.'
      ],
      projectChoices: [
        'Resin Chess Board',
        'Ocean Wave Clock',
        'Resin Wall Art'
      ],
      included: [
        'Tools & materials: resin, pigments, molds, gloves, masks, finishing supplies',
        'Step-by-step guidance from TheResinWorld',
        'Light refreshments',
        'Photos and short video clips of process'
      ],
      info: {
        duration: '4 hours',
        skillLevel: 'Beginner-friendly',
        capacity: '15 participants per session'
      }
    },
    image: '/images/resin.jpeg'
  }
]

const sessions = [
  { value: '10am-3pm', label: '10 AM – 3 PM' },
  { value: '4pm-8pm', label: '4 PM – 8 PM' }
]

const scrollToBooking = () => {
  showBookingForm.value = true
  nextTick(() => {
    const bookingSection = document.getElementById('booking-section')
    if (bookingSection) {
      bookingSection.scrollIntoView({ behavior: 'smooth' })
    }
  })
}

const handleFileUpload = (event: Event) => {
  const target = event.target as HTMLInputElement
  if (target.files && target.files[0]) {
    const file = target.files[0]
    store.user.designImage = file
    
    const reader = new FileReader()
    reader.onload = (e) => {
      previewImage.value = e.target?.result as string
    }
    reader.readAsDataURL(file)
  }
}

const removeImage = () => {
  store.user.designImage = null
  previewImage.value = null
  if (fileInputRef.value) {
    fileInputRef.value.value = ''
  }
}

const validateForm = () => {
  const errors: string[] = []
  
  if (!store.user.name || store.user.name.trim() === '') {
    errors.push('Please enter your full name')
  }
  
  if (!store.user.phone || store.user.phone.trim() === '') {
    errors.push('Please enter your phone number')
  }
  
  if (!store.user.email || store.user.email.trim() === '') {
    errors.push('Please enter your email address')
  } else {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
    if (!emailRegex.test(store.user.email)) {
      errors.push('Please enter a valid email address')
    }
  }
  
  if (!store.user.eventType || store.user.eventType.trim() === '') {
    errors.push('Please select a workshop type')
  }
  
  if (!store.user.session || store.user.session.trim() === '') {
    errors.push('Please select your preferred session')
  }
  
  if (!store.user.consent) {
    errors.push('You must agree to the booking policy')
  }
  
  return errors
}

const formatPrice = (amount: number) => {
  return new Intl.NumberFormat('en-NG', {
    style: 'currency',
    currency: 'NGN',
    minimumFractionDigits: 0
  }).format(amount)
}

const handlePayment = async () => {
  validationErrors.value = []
  const errors = validateForm()
  
  if (errors.length > 0) {
    validationErrors.value = errors
    return
  }
  
  isLoading.value = true
  
  try {
    const supabase = createClient(
      config.public.supabaseUrl,
      config.public.supabaseAnonKey
    )
    
    // Upload image if provided
    let imageUrl = null
    if (store.user.designImage) {
      const fileExt = store.user.designImage.name.split('.').pop()
      const fileName = `${Date.now()}_${Math.random().toString(36).substring(7)}.${fileExt}`
      const filePath = `design-images/${fileName}`
      
      const { error: uploadError } = await supabase.storage
        .from('designs')
        .upload(filePath, store.user.designImage)
      
      if (!uploadError) {
        const { data } = supabase.storage.from('designs').getPublicUrl(filePath)
        imageUrl = data.publicUrl
      }
    }
    
    // Save user data to database
    const { error } = await supabase
      .from('users')
      .insert({
        name: store.user.name,
        phone: store.user.phone,
        email: store.user.email,
        eventType: store.user.eventType,
        session: store.user.session,
        designImage: imageUrl,
        consent: store.user.consent,
        amount: 100000,
        status: 'pending_payment'
      })
    
    if (error) {
      console.error('Error saving data:', error)
      validationErrors.value = ['Error saving your information. Please try again.']
      isLoading.value = false
      return
    }
    
    // TODO: Integrate Paystack or Flutterwave payment here
    // Initialize payment gateway with amount: 100000
    // After successful payment, update status to 'paid' and send confirmation
    
    // For now, simulate payment success and redirect
    router.push('/final')
    
  } catch (error) {
    console.error('Error processing payment:', error)
    validationErrors.value = ['An error occurred. Please try again.']
    isLoading.value = false
  }
}

const clearValidationErrors = () => {
  if (validationErrors.value.length > 0) {
    validationErrors.value = []
  }
}
</script>

<template>
  <main class="w-full">
    <!-- Hero Section -->
    <section class="min-h-screen flex flex-col justify-center items-center px-4">
      <div class="title items-center justify-center uppercase space-y-2 md:space-y-4 mb-4 flex flex-col text-center text-2xl md:text-3xl lg:text-4xl">
        <span class="text-5xl md:text-8xl mt-4">CIRku</span>
      </div>
      
      <div class="title uppercase space-y-2 md:space-y-4 mb-4 flex flex-col text-center text-2xl md:text-3xl lg:text-4xl">
        <span class="text-lg md:text-xl lg:text-2xl mt-4">Your Circle of creation</span>
        <span class="text-sm md:text-base mt-2">DIY Creative Experience</span>
      </div>
      
      <div class="w-full justify-center flex max-w-sm md:max-w-md px-4 mt-10">
        <CtaBtn @click="scrollToBooking" text="Book Workshop" />
    </div>      
      
      <a 
        href="https://wa.me/+2349036322816?text=Hello!%20I%20would%20like%20to%20make%20a%20reservation%20for%20Cirku%20Creative%20Experience." 
      target="_blank" 
      rel="noopener noreferrer"
        class="text-center font-bold my-5 text-sm md:text-base px-4 block transition-colors"
      >
        Contact <span>09036322816</span><br />For Reservations.
      </a>
    </section>

    <!-- Workshops Section -->
    <section class="py-20 px-4">
      <div class="max-w-6xl mx-auto space-y-32">
        <div 
          v-for="workshop in workshops" 
          :key="workshop.id"
          class="scroll-mt-24"
        >
          <div class="flex flex-col md:flex-row items-center gap-8 md:gap-12">
            <!-- Image -->
            <div class="w-full md:w-1/2">
              <div class="aspect-[4/3] bg-gray-800 border-2 border-black flex items-center justify-center">
                <img 
                  :src="workshop.image" 
                  :alt="workshop.name"
                  class="w-full h-full object-cover"
                  @error="(e) => { (e.target as HTMLImageElement).src = 'data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' width=\'800\' height=\'600\'%3E%3Crect fill=\'%231a1a1a\' width=\'800\' height=\'600\'/%3E%3Ctext x=\'50%25\' y=\'50%25\' text-anchor=\'middle\' dominant-baseline=\'middle\' fill=\'%23ffffff\' font-size=\'24\' font-family=\'Arial\'%3E{{ workshop.name }}%3C/text%3E%3C/svg%3E' }"
                />
              </div>
            </div>

            <!-- Content -->
            <div class="w-full md:w-1/2 space-y-6">
              <div class="title text-3xl md:text-4xl">
                <span>{{ workshop.name }}</span>
              </div>
              
              <div class="space-y-4 text-base md:text-lg">
                <p>{{ workshop.description }}</p>
                
                <!-- Resin Art Special Details -->
                <div v-if="workshop.id === 'resin-art' && workshop.details" class="space-y-4 mt-6">
                  <div>
                    <p class="font-semibold mb-2">Before the class:</p>
                    <ul class="list-disc list-inside space-y-1 ml-2">
                      <li v-for="(item, idx) in workshop.details.beforeClass" :key="idx">{{ item }}</li>
                    </ul>
                  </div>
                  
                  <div>
                    <p class="font-semibold mb-2">Project choices:</p>
                    <ul class="list-disc list-inside space-y-1 ml-2">
                      <li v-for="(item, idx) in workshop.details.projectChoices" :key="idx">{{ item }}</li>
                    </ul>
                  </div>
                  
                  <div>
                    <p class="font-semibold mb-2">What's included:</p>
                    <ul class="list-disc list-inside space-y-1 ml-2">
                      <li v-for="(item, idx) in workshop.details.included" :key="idx">{{ item }}</li>
                    </ul>
                  </div>
                  
                  <div>
                    <p class="font-semibold mb-2">Details:</p>
                    <ul class="list-disc list-inside space-y-1 ml-2">
                      <li>Duration: {{ workshop.details.info.duration }}</li>
                      <li>Skill level: {{ workshop.details.info.skillLevel }}</li>
                      <li>Capacity: {{ workshop.details.info.capacity }}</li>
                    </ul>
                  </div>
                </div>
              </div>

              <div class="flex flex-col md:flex-row items-start md:items-center gap-4 pt-4">
                <div>
                  <p class="font-semibold">Capacity: {{ workshop.capacity }}</p>
                  <p class="font-semibold text-xl mt-2">{{ formatPrice(workshop.price) }} per person</p>
                </div>
                <CtaBtn @click="scrollToBooking" text="Book Now" />
              </div>
            </div>
          </div>
    </div>
    </div>
    </section>

    <!-- Booking & Payment Section -->
    <section id="booking-section" class="py-20 px-4 min-h-screen flex items-center">
      <div class="max-w-2xl mx-auto w-full space-y-8">
        <div class="title mb-4 flex flex-col text-center text-3xl md:text-4xl">
          <span>Book Your Workshop</span>
</div>
        
        <div class="text-center mb-8">
          <span>
            Complete the form below to reserve your spot. All workshops are ₦100,000 per person.
          </span>
        </div>

        <!-- Validation errors -->
        <div v-if="validationErrors.length > 0" class="w-full space-y-2">
          <div 
            v-for="(error, index) in validationErrors" 
            :key="index"
            class="text-sm text-center"
          >
            {{ error }}
          </div>
        </div>

        <!-- Booking Form -->
        <div class="space-y-6">
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

          <!-- Phone Number -->
          <div class="w-full">
            <label class="block mb-2 text-sm font-semibold">Phone Number (WhatsApp)</label>
            <InputField 
              class="w-full" 
              v-model="store.user.phone" 
              placeholder="Enter your WhatsApp number" 
              @input="clearValidationErrors" 
            />
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

          <!-- Workshop Type -->
          <div class="w-full">
            <label class="block mb-2 text-sm font-semibold">Workshop Type</label>
            <select 
              v-model="store.user.eventType"
              class="event-type-select w-full py-3 px-4 border-2 border-black rounded-none bg-transparent text-white text-base font-['InterFont'] cursor-pointer outline-none pr-10"
              @change="clearValidationErrors"
            >
              <option value="" disabled>Select a workshop</option>
              <option 
                v-for="workshop in workshops" 
                :key="workshop.id" 
                :value="workshop.id"
              >
                {{ workshop.name }} ({{ workshop.capacity }})
              </option>
            </select>
          </div>

          <!-- Preferred Session -->
          <div class="w-full">
            <label class="block mb-2 text-sm font-semibold">Preferred Session</label>
            <select 
              v-model="store.user.session"
              class="event-type-select w-full py-3 px-4 border-2 border-black rounded-none bg-transparent text-white text-base font-['InterFont'] cursor-pointer outline-none pr-10"
              @change="clearValidationErrors"
            >
              <option value="" disabled>Select a session</option>
              <option 
                v-for="session in sessions" 
                :key="session.value" 
                :value="session.value"
              >
                {{ session.label }}
              </option>
            </select>
          </div>

          <!-- Upload Design / Reference Image -->
          <div class="w-full">
            <label class="block mb-2 text-sm font-semibold">Upload Design / Reference Image</label>
            <div class="w-full">
              <input
                ref="fileInputRef"
                type="file"
                accept="image/*"
                @change="handleFileUpload"
                class="hidden"
                id="design-upload"
              />
              <label 
                for="design-upload"
                class="block w-full py-3 px-4 border-2 border-black rounded-none bg-transparent text-white cursor-pointer text-center transition-all hover:bg-white/10"
              >
                <span v-if="!previewImage">Click to upload image</span>
                <span v-else class="flex items-center space-x-2">
                  <span>Image selected</span>
                  <span @click.stop="removeImage" class="text-xs underline">Remove</span>
                </span>
              </label>
              <div v-if="previewImage" class="mt-2">
                <img :src="previewImage" alt="Preview" class="max-w-full max-h-48 object-contain border-2 border-black" />
              </div>
            </div>
          </div>

          <!-- Consent Checkbox -->
          <div class="w-full">
            <label class="flex items-start space-x-3 cursor-pointer">
              <input
                type="checkbox"
                v-model="store.user.consent"
                @change="clearValidationErrors"
                class="checkbox-custom mt-1 w-5 h-5 cursor-pointer border-2 border-black rounded-none bg-transparent relative"
              />
              <span class="text-sm">
                I understand that all bookings are final — no refunds and no rescheduling.
              </span>
            </label>
          </div>

          <!-- Payment Summary -->
          <div class="w-full border-2 border-black p-6 bg-transparent space-y-3 mt-6">
            <div class="flex justify-between items-center">
              <span class="font-semibold">Total Amount:</span>
              <span class="text-2xl font-bold">{{ formatPrice(100000) }}</span>
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
        </div>

        <!-- Location & Policy -->
        <div class="space-y-4 mt-12 text-center">
          <div>
            <p class="font-semibold mb-2">Location:</p>
            <p>CIRKU Studio<br />2C Okotie Eboh Street, Ikoyi, Lagos</p>
          </div>
          <div class="border-2 border-black p-4 bg-transparent">
            <p class="font-semibold mb-2">Policy:</p>
            <p>All bookings are final. No refunds. No rescheduling.</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Footer -->
    <footer class="text-center py-10">
      <span class="text-xs text-center footer-font">Circle Ent. {{ new Date().getFullYear() }}</span>
        </footer>
    </main>
</template>

<style scoped>
.event-type-select {
  appearance: none;
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23FFFFFF' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
  background-repeat: no-repeat;
  background-position: right 16px center;
}

.event-type-select option {
  background: #000000;
  color: #FFFFFF;
}

.checkbox-custom {
  appearance: none;
  -webkit-appearance: none;
}

.checkbox-custom:checked {
  background: #000000;
}

.checkbox-custom:checked::after {
  content: '✓';
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  color: #FFFFFF;
  font-size: 14px;
  font-weight: bold;
}
</style>
