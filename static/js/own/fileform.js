// enable buttons when fields changed
// TODO: disable save/delete when code is empty
function changed(state) {
  console.log('data changed');
  var btns = document.getElementsByClassName('edit');
  for (var k in btns) {
    btns[k].disabled = !state;
  }
}

// reset form changes and disable buttons
function resetForm() {
  console.log('reset');
  document.getElementById("editForm").reset();
  var btns = document.getElementsByClassName('edit');
  for (var k in btns) {
    btns[k].disabled = true;
  }
}

// show confirmation dialog
function ask() {
  var tag=document.getElementById("code").value;
  document.getElementById("tag").innerText=tag;
  var q=document.getElementById("confirm");
  //  q.style.display='inline-block';
  q.classList.remove('hide');
}

// hide dialog and process confirmation
function del(confirmed) {
  var q = document.getElementById("confirm");
  //  q.style.display='';
  q.classList.add('hide');
  if (confirmed) {
    var tag = document.getElementById("code").value;
    var f = document.getElementById("editForm");
    call(f,'tag_del',{code: tag}, function(){ setTimeout(back, 1000); });
  }
}

// go back after delete
function back() {
  window.history.go(-1);
  // if no history:
  window.location.pathname = '/';
}

// save file
function save(f) {
  var args = {
    code: f.elements["code"].value,
    data: f.elements["src"].value
  };
  call(f,'tag_set',args);
}

// call API
function call(f, method, args, onSuccess) {
  disable_form(f, true);
  console.log('Call '+ method);
  var xhr = new XMLHttpRequest();
  xhr.open('POST', 'rpc/' + method, true);
  xhr.onreadystatechange = function() { // (3)
    if (xhr.readyState != 4) return;
    console.log('Done');
    if (xhr.status != 200) {
      console.log(xhr.status + ': ' + xhr.statusText);
    } else {
      console.log('Result: ' + xhr.responseText);
    }
    disable_form(f, false);
    changed(false);
    if (onSuccess) onSuccess();
  }
  xhr.send(JSON.stringify(args));
}

// code from https://gist.github.com/Peacegrove/5534309
function disable_form(form, state) {
  var inputs = form.getElementsByTagName('input'),
      textareas = form.getElementsByTagName('textarea'),
      buttons = form.getElementsByTagName('button'),
      selects = form.getElementsByTagName('select');

  disable_elements(inputs, state);
  disable_elements(textareas,state);
  disable_elements(buttons,state);
  disable_elements(selects, state);
}

// Disables a collection of form-elements.
function disable_elements(elements, state) {
  var length = elements.length;
  while(length--) {
    elements[length].disabled = state;
  }
}

// return true if at least one of elems has not default value
function is_changed(elems) {
  for (i = 0; i < elems.length; i++) {
    if (elems[i].value != elems[i].defaultValue) return true;
  }
  return false;
}

// textarea onChange event handler
// code from https://stackoverflow.com/a/14029861/5199825
function handle_changes(ids) {
  var elems = new(Array);
  for (i = 0; i < ids.length; i++) {
    var area = document.getElementById(ids[i]);
    elems[i] = area;
    if (area.addEventListener) {
      area.addEventListener('input', function() {
        // event handling code for sane browsers
        var state = area.value != area.defaultValue;
        changed(is_changed(elems));
      }, false);
    } else if (area.attachEvent) {
      area.attachEvent('onpropertychange', function() {
        // IE-specific event handling code
        var state = area.value != area.defaultValue;
        changed(is_changed(elems));
      });
    }
  }
}
