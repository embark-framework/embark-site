(function() {
  'use strict';

  // Search
  const searchWrap = document.getElementById('search-input-wrap');
  const searchInput = document.getElementById('search-input');
  const className = 'active';

  searchWrap.onclick = function(e) {
    searchWrap.classList.add(className);
    searchInput.focus();
  };

  searchInput.onblur = function(e) {
    searchWrap.classList.remove(className);
  };
}());
