(function() {
  App.room = App.cable.subscriptions.create("RoomChannel", {
    connected: function() {
      // alert('socket已經鏈接');
      console.log('socket已經鏈接');
    },
    disconnected: function() {
      alert('socket鏈接斷開');
    },
    received: function(data) {
      console.log(data['message']);
      signinPersonArray.push(data['message']['user_info']);
      $('#signin_count').html(data['message']['signin_count']);
      return $('#messages').append(data['message']['signin_count']);
    },
    speak: function(message) {
      return this.perform('speak', {
        message: message
      });
    }
  });

  $(document).on('keypress', '[data-behavior~=room_speaker]', function(event) {
    if (event.keyCode === 13) {
      App.room.speak(event.target.value);
      event.target.value = "";
      return event.preventDefault();
    }
  });

}).call(this);
