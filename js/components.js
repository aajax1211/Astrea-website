/* =============================================
   ASTREA eDISCOVERY — COMPONENTS
   Header + footer embedded directly — no fetch.
   Works on GitHub Pages, localhost, everywhere.
   ============================================= */

const HEADER_HTML = `
<header class="nav-wrapper">
  <nav class="nav">
    <a href="index.html" class="nav-logo">
      <img src="images/logo.jpg" alt="Astrea eDiscovery Logo">
    </a>
    <ul class="nav-links" id="navLinks">
      <li><a href="index.html">Home</a></li>
      <li><a href="about.html">About</a></li>
      <li><a href="careers.html">Careers</a></li>
      <li><a href="resources.html">Resources</a></li>
      <li><a href="contact.html" class="btn-nav">Contact Us</a></li>
    </ul>
    <button class="hamburger" id="hamburgerBtn" aria-label="Open menu">
      <span></span><span></span><span></span>
    </button>
  </nav>
</header>`;

const FOOTER_HTML = `
<footer class="footer">
  <div class="footer-inner">
    <div class="footer-top">
      <div class="footer-brand">
        <div class="footer-brand-name">Astrea eDiscovery</div>
        <div class="footer-brand-tag">Where people &amp; processes meet common sense</div>
        <div class="footer-social-links">
          <a href="https://www.linkedin.com/company/astrea-ediscovery" class="footer-social-btn" aria-label="LinkedIn" target="_blank" rel="noopener">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor">
              <path d="M16 8a6 6 0 016 6v7h-4v-7a2 2 0 00-2-2 2 2 0 00-2 2v7h-4v-7a6 6 0 016-6zM2 9h4v12H2z"/>
              <circle cx="4" cy="4" r="2"/>
            </svg>
          </a>
        </div>
      </div>
      <div class="footer-col">
        <div class="footer-col-title">Navigate</div>
        <ul>
          <li><a href="index.html">Home</a></li>
          <li><a href="about.html">About</a></li>
          <li><a href="careers.html">Careers</a></li>
          <li><a href="resources.html">Resources</a></li>
          <li><a href="contact.html">Contact</a></li>
        </ul>
      </div>
      <div class="footer-col">
        <div class="footer-col-title">Legal</div>
        <ul>
          <li><a href="#">Terms</a></li>
          <li><a href="#">Privacy</a></li>
          <li><a href="#">Cookies</a></li>
        </ul>
      </div>
      <div class="footer-newsletter">
        <div class="footer-col-title">Newsletter</div>
        <p class="footer-newsletter-sub">Want to know what we are up to? Sign up and join our tribe.</p>
        <div class="footer-form">
          <input type="email" placeholder="Email address">
          <button>Subscribe</button>
        </div>
      </div>
    </div>
    <div class="footer-bottom">
      <p class="footer-copy">2025 Astrea eDiscovery. All Rights Reserved.</p>
      <div class="footer-legal">
        <a href="#">Terms</a>
        <a href="#">Privacy</a>
        <a href="#">Cookies</a>
      </div>
    </div>
  </div>
</footer>`;

function injectComponents() {
  const header = document.getElementById('site-header');
  const footer = document.getElementById('site-footer');
  if (header) header.innerHTML = HEADER_HTML;
  if (footer) footer.innerHTML = FOOTER_HTML;
}

function setActiveNav() {
  const page = window.location.pathname.split('/').pop() || 'index.html';
  document.querySelectorAll('.nav-links a').forEach(a => {
    a.classList.remove('active');
    const href = a.getAttribute('href');
    if (href === page || (page === '' && href === 'index.html')) {
      a.classList.add('active');
    }
  });
}

function initNav() {
  const hamburger = document.getElementById('hamburgerBtn');
  const navLinks  = document.getElementById('navLinks');
  if (!hamburger || !navLinks) return;
  hamburger.addEventListener('click', () => {
    navLinks.classList.toggle('open');
    hamburger.classList.toggle('open');
  });
  document.addEventListener('click', e => {
    if (!e.target.closest('.nav')) {
      navLinks.classList.remove('open');
      hamburger.classList.remove('open');
    }
  });
}

function initScrollNav() {
  const navWrapper = document.querySelector('.nav-wrapper');
  if (!navWrapper) return;
  let lastScroll = 0, ticking = false;
  window.addEventListener('scroll', () => {
    if (!ticking) {
      requestAnimationFrame(() => {
        const current = window.scrollY;
        if (current > lastScroll && current > 80) {
          navWrapper.classList.add('nav-hidden');
        } else {
          navWrapper.classList.remove('nav-hidden');
        }
        lastScroll = current <= 0 ? 0 : current;
        ticking = false;
      });
      ticking = true;
    }
  });
}

function initNewsletter() {
  document.querySelectorAll('.footer-form').forEach(form => {
    const btn = form.querySelector('button');
    const input = form.querySelector('input');
    if (!btn || !input) return;
    btn.addEventListener('click', () => {
      const email = input.value.trim();
      if (!email || !email.includes('@')) {
        input.style.outline = '2px solid #ff6b6b';
        setTimeout(() => input.style.outline = '', 2000);
        return;
      }
      btn.textContent = 'Thanks!';
      btn.style.background = '#4CAF50';
      btn.style.color = 'white';
      input.value = '';
      setTimeout(() => {
        btn.textContent = 'Subscribe';
        btn.style.background = '';
        btn.style.color = '';
      }, 3000);
    });
  });
}

function initReveal() {
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(el => {
      if (el.isIntersecting) {
        el.target.classList.add('visible');
        observer.unobserve(el.target);
      }
    });
  }, { threshold: 0.12 });
  document.querySelectorAll('.reveal').forEach(el => observer.observe(el));
}

function init() {
  injectComponents();
  setActiveNav();
  initNav();
  initScrollNav();
  initNewsletter();
  initReveal();
}

if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', init);
} else {
  init();
}
