// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";

// Function to handle modal visibility, including overlay
window.toggleModal = function(action) {
  const overlay = document.getElementById("modal-overlay");

  if (action === 'open') {
    overlay.classList.remove("hidden");
  } else if (action === 'close') {
    overlay.classList.add("hidden");
  }
};


// Event listener for DOMContentLoaded
document.addEventListener("DOMContentLoaded", () => {
  // Button to open the modal
  const openModalBtn = document.getElementById("open-modal-btn");

  // Buttons to close the modal, including the close button inside the modal
  const closeModalBtns = document.querySelectorAll(".close-modal-btn");

  // Event listener for opening the modal
  if (openModalBtn) {
    openModalBtn.addEventListener("click", () => {
      toggleModal('open');
    });
  }

  // Event listeners for closing the modal
  closeModalBtns.forEach(btn => { 
    btn.addEventListener("click", () => {
      toggleModal('close');
    });
  });

  // Optional: Close modal when clicking outside the modal content
  const overlay = document.getElementById("modal-overlay");
  if (overlay) {
    overlay.addEventListener("click", (event) => {
      // Ensure it only closes when clicking on the overlay background
      if (event.target === overlay) {
        toggleModal('close');
      }
    });
  }
});

document.addEventListener('DOMContentLoaded', () => {
  const toasts = document.querySelectorAll('.toast');
  toasts.forEach(toast => {
    setTimeout(() => {
      fadeOutToast(toast);
    }, 5000);
  });
});

function fadeOutToast(toast) {
  toast.classList.remove('opacity-100');
  toast.classList.add('opacity-0', 'translate-x-full');
  setTimeout(() => {
    toast.remove();
  }, 300);
}

function closeToast(toast) {
  fadeOutToast(toast);
}
