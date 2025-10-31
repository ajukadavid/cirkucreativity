<template>
    <div class="flex flex-col">
        <div class="flex flex-col justify-center items-center space-y-5 mt-5">
            <span class="footer text-[#89898B] text-center text-sm font-bold">ABOUT</span>
            <span class="title text-4xl bg-gradient-to-r from-[#FFFFFF] to-[#4C4B4B] text-transparent bg-clip-text">Mavo</span>
            <img src="/images/star2.png" class="h-8 absolute left-10 top-20"/>

                <div class="social-container">
                    <div class="social-wrapper">
                        <ul class="social-list">
                            <li><a href="https://www.instagram.com/mavoswago?igsh=NTB2b3h3b2lrdHRp" class="social-link instagram">
                                <i class="fab fa-instagram" aria-hidden="true"></i>
                            </a></li>
                            <li><a href="https://x.com/mavoswago?s=21" class="social-link twitter">
                                <i class="fab fa-twitter" aria-hidden="true"></i>
                            </a></li>
                        </ul>
                    </div>
                </div>
                <img src="/images/star2.png" class="h-8 absolute right-10 top-60"/>

        </div>
        <div class="flex flex-col justify-center items-center space-y-5 mt-5">
            <img src="/images/inr.png" class="w-8" />
            <a target="_blank" href="https://theicent.lnk.to/Kilometer-II" class="clickable-link">
                <div
                class="title animate-pulse bg-gradient-to-r from-[#FFFFFF] to-[#4C4B4B] mb-4 flex flex-col text-center text-transparent bg-clip-text text-3xl hover:from-[#F0F0F0] hover:to-[#6B7280] transition-all duration-300 cursor-pointer">
                <span>Kilometer <br /> II</span>
            </div>
            </a>
       
            
        </div>
        <div class="flex flex-col justify-center items-center space-y-5 mt-5">
            <img src="/images/klr.png" class="w-8" />
            <img src="/images/star2.png" class="h-8 relative right-40 top-10"/>

            <div
                class="title bg-gradient-to-r from-[#FFFFFF] to-[#4C4B4B] mb-4 flex flex-col text-center text-transparent bg-clip-text text-3xl ">
                <span>Cirku <br /> Parties</span>
            </div>
            
                <div class="text-center">
                    <span class=" footer text-[#89898B]">Coming soon....</span>

                </div>
                <img src="/images/star2.png" class="h-8 relative  left-20 bottom-4"/>

        </div>


        <footer class="text-center my-5">
            <span class="text-xs text-center  footer-font text-[#d1cfd8]">Circle Ent. 2025</span>
        </footer>
    </div>
</template>

<style scoped>
/* Import Font Awesome for icons */
@import url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css');

/* Clickable link styles */
.clickable-link {
  text-decoration: none;
  display: inline-block;
  transition: transform 0.2s ease;
}

.clickable-link:hover {
  transform: scale(1.05);
}

.clickable-link:focus {
  outline: 2px solid #9CA3AF;
  outline-offset: 4px;
  border-radius: 8px;
}

.social-container {
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 20px;
}

.social-wrapper {
  position: relative;
  width: 200px;
  height: 70px;
}

.social-list {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 200px;
  height: 70px;
  list-style: none;
  padding: 0;
  margin: 0;
}

.social-list::before {
  content: '\f064'; /* Share icon */
  font-family: 'FontAwesome';
  position: absolute;
  top: 0;
  left: 0;
  background: linear-gradient(180deg, #D1D5DB 0%, #9CA3AF 100%);
  color: #1F2937;
  z-index: 10;
  width: 100%;
  height: 70px;
  text-align: center;
  line-height: 70px;
  font-size: 30px;
  border-radius: 35px;
  transition: 1s;
  transition-delay: 0.5s;
  box-shadow: 0px 6px 12px rgba(55, 65, 81, 0.08);
}

.social-list:hover::before {
  transition-delay: 0s;
  width: 70px;
}

.social-list:hover .social-link {
  transform: rotate(-360deg);
  transition-delay: 0.5s;
}

.social-link {
  position: absolute;
  left: 0;
  display: inline-block;
  color: #1F2937;
  text-decoration: none;
  width: 70px;
  height: 70px;
  text-align: center;
  line-height: 70px;
  font-size: 30px;
  border-radius: 35px;
  transition: 1s;
  transition-delay: 0s;
  background: linear-gradient(180deg, #D1D5DB 0%, #9CA3AF 100%);
  box-shadow: 0px 6px 12px rgba(55, 65, 81, 0.08);
}

.social-link:hover {
  background: linear-gradient(180deg, #F0F0F0 0%, #D0D0D0 100%);
  box-shadow: 0px 8px 16px rgba(55, 65, 81, 0.12);
}

.social-link.instagram {
  background: linear-gradient(180deg, #D1D5DB 0%, #9CA3AF 100%);
}

.social-link.twitter {
  background: linear-gradient(180deg, #D1D5DB 0%, #9CA3AF 100%);
}

.social-list:hover .social-link.instagram {
  left: calc((70px + 15px) * 1);
}

.social-list:hover .social-link.twitter {
  left: calc((70px + 15px) * 2);
}

/* Responsive adjustments */
@media (max-width: 768px) {
  .social-wrapper {
    width: 160px;
    height: 60px;
  }
  
  .social-list {
    width: 160px;
    height: 60px;
  }
  
  .social-list::before {
    height: 60px;
    line-height: 60px;
    font-size: 24px;
    border-radius: 30px;
  }
  
  .social-link {
    width: 60px;
    height: 60px;
    line-height: 60px;
    font-size: 24px;
    border-radius: 30px;
  }
  
  .social-list:hover .social-link.instagram {
    left: calc((60px + 10px) * 1);
  }
  
  .social-list:hover .social-link.twitter {
    left: calc((60px + 10px) * 2);
  }
  
  .social-list:hover::before {
    width: 60px;
  }
}
</style>