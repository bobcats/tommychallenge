const submissions = [
  {
    created_by: "Brian",
    created_date: "2018-01-14"
  },
  {
    created_by: "Jacob",
    created_date: "2018-01-31"
  },
  {
    created_by: "Tommy",
    created_date: "2018-01-01"
  },
  {
    created_by: "Michael",
    created_date: "2018-02-02"
  },
  {
    created_by: "Brian",
    created_date: "2018-02-02"
  },
  {
    created_by: "Jacob",
    created_date: "2018-02-02"
  },
  {
    created_by: "Tommy",
    created_date: "2018-02-02"
  },
  {
    created_by: "Eyvette",
    created_date: "2018-03-02"
  }
]

let current_submissions = [];
let previous_submissions = [];

submissions.forEach(groupSubmissions);
createBodyItems(current_submissions, "currentSubmissions");
createBodyItems(previous_submissions, "previousSubmissions");

function groupSubmissions(submission) {
  const current_month = new Date(Date.now()).getMonth();
  let submission_month = new Date(submission.created_date).getMonth();
  if (submission_month == current_month) {
    current_submissions.push(submission);
  }
  else {
    previous_submissions.push(submission)
  }
};

function createBodyItems(group, elementID) {
  for (i = 0; i < group.length; i++){
    const individualSubmission = document.createElement("div");
    individualSubmission.className = "mainSubmissionIndividual";
    individualSubmission.id = `${elementID}[${i}]`;
    document.getElementById(elementID).appendChild(individualSubmission);

    const name = document.createElement('span');
    name.innerHTML = group[i].created_by;
    name.className = "alignLeft";

    const created_date = document.createElement('span');
    created_date.innerHTML = group[i].created_date;
    created_date.className = "alignRight";

    document.getElementById(`${elementID}[${i}]`).appendChild(name);
    document.getElementById(`${elementID}[${i}]`).appendChild(created_date);

    createPlayer(i, `${elementID}`);
  }
}

function createPlayer(index, elementID) {
  var player = document.createElement("AUDIO");
  player.setAttribute("controls", "controls");
  player.className ="submissionPlayers";
  document.getElementById(`${elementID}[${index}]`).appendChild(player);
}

function hide(container) {
  document.getElementById(container).style.display = "none";
  document.getElementById(`${container}Link`).style.fontWeight = "normal";
}

function toggleBody(container) {
  const allContainers = ["currentChallenge", "previousChallenge", "about", "login"];

  allContainers.forEach(hide);
  document.getElementById(container).style.display = "block";
  document.getElementById(`${container}Link`).style.fontWeight = "bold";
}
