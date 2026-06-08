/**
 * Ouvre la modale de modification du profil
 */
function openEdit() { 
  document.getElementById('editModal').classList.add('show'); 
}

/**
 * Ferme la modale de modification du profil
 */
function closeEdit() { 
  document.getElementById('editModal').classList.remove('show'); 
}

document.getElementById('editModal').addEventListener('click', function(e) {
  if (e.target === this) {
    closeEdit();
  }
});
