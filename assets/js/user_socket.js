// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// Bring in Phoenix channels client library:
import {Socket} from "phoenix"
createSocket = (topicId) => {
  let socket = new Socket("/socket", {params: {token: window.userToken}})
  socket.connect()
  
  // Now that you are connected, you can join channels with a topic.
  // Let's assume you have a channel with a topic named `room` and the
  // subtopic is its id - in this case 42:
  let channel = socket.channel(`comments:${topicId}`, {})
  channel.join()
    .receive("ok", resp => { console.log("Joined successfully", resp) 
    renderComments(resp.comments)
  })
    .receive("error", resp => { console.log("Unable to join", resp) })

  const button = document.querySelector('button')
  const comment = document.querySelector('input')

  button.addEventListener('click', () => {
    channel.push('add',{comment: comment.value})
  })

  channel.on(`comments:${topicId}:new`,renderComment)
}

function renderComments(comments) {
  const renderedComments = comments.map(comment => {
    return commentTemplate(comment)
  })

  document.querySelector('.collection').innerHTML = renderedComments.join('')
}

function renderComment(event) {
  const renderedComment = commentTemplate(event.comment)

  document.querySelector('.collection').innerHTML += renderedComment
}

function commentTemplate(comment) {
  let email = 'Anonymous'
  if (comment.user) {
    email = comment.user.email
  }

  return `
    <li class="collection-item">
     ${comment.content}
     <div class="secondary-content">
      ${email}
     </div>
    </li>
  `
}
