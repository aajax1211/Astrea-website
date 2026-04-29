/* =============================================
   ASTREA eDISCOVERY — COMPONENT LOADER
   Fetches header.html + footer.html and injects
   them into every page automatically.
   ============================================= */

async function loadComponent(id, path) {
  const el = document.getElementById(id);
  if (!el) return;
  try {
    const res = await fetch(path);
    if (!res.ok) throw new Error(`Failed to load ${path}`);
    el.innerHTML = await res.text();
  } catch (err) {
    console.warn('Component load error:', err);
  }
}

async function initComponents() {
  await Promise.all([
    loadComponent('site-header', 'components/header.html'),
    loadComponent('site-footer', 'components/footer.html'),
  ]);

  // ── Set active nav link based on current page ──
  const page = window.location.pathname.split('/').pop() || 'index.html';
  document.querySelectorAll('.nav-links a').forEach(a => {
    const href = a.getAttribute('href');
    if (href === page || (page === '' && href === 'index.html')) {
      a.classList.add('active');
    }
  });

  // ── Mobile nav toggle ──
  const hamburger = document.getElementById('hamburgerBtn');
  const navLinks  = document.getElementById('navLinks');

  if (hamburger && navLinks) {
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

  // ── Scroll hide / show nav ──
  const navWrapper = document.querySelector('.nav-wrapper');
  if (navWrapper) {
    let lastScroll = 0;
    let ticking = false;

    window.addEventListener('scroll', () => {
      if (!ticking) {
        requestAnimationFrame(() => {
          const current = window.scrollY;
          // Hide when scrolling DOWN past 80px, show when scrolling UP
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

  // ── Newsletter form handler ──
  document.querySelectorAll('.footer-form').forEach(form => {
    const btn   = form.querySelector('button');
    const input = form.querySelector('input');
    if (!btn || !input) return;

    btn.addEventListener('click', () => {
      const email = input.value.trim();
      if (!email || !email.includes('@')) {
        input.style.outline = '2px solid #ff6b6b';
        setTimeout(() => input.style.outline = '', 2000);
        return;
      }
      btn.textContent = 'Thanks! ✓';
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

  // ── Scroll reveal (re-init after components load) ──
  initReveal();
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

// ── Run on DOM ready ──
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', initComponents);
} else {
  initComponents();
}
