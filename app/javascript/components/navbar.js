const initUpdateNavbarOnScroll = () => {
  const navbar = document.querySelector('.sticky-navbar');
  if (navbar) {
    window.addEventListener('scroll', () => {
      console.log(window.scrollY);
      if (window.scrollY >= 120) {
        navbar.classList.add('navbar-lewagon-white');
      } else {
        navbar.classList.remove('navbar-lewagon-white');
      }
    });
  }
}

export { initUpdateNavbarOnScroll };
