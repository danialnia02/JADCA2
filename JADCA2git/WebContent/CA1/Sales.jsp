<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<%@ include file="RootHeader.jsp"%>


<body>


<div class="grid-container">

  <main class="main">
  
<div class="main-overview">
  <div class="overviewcard">
    <div class="overviewcard__icon">Overview</div>
    <div class="overviewcard__info">Card</div>
  </div>
  <div class="overviewcard">
    <div class="overviewcard__icon">Overview</div>
    <div class="overviewcard__info">Card</div>
  </div>
  <div class="overviewcard">
    <div class="overviewcard__icon">Overview</div>
    <div class="overviewcard__info">Card</div>
  </div>
  <div class="overviewcard">
    <div class="overviewcard__icon">Overview</div>
    <div class="overviewcard__info">Card</div>
  </div>
</div>

<div class="main-cards">
  <div class="card">Card</div>
  <div class="card">Card</div>
  <div class="card">Card</div>
</div>

</main>
  <footer class="footer"></footer>
</div>


</body>

<style>
.grid-container {
  display: grid;
  background:#DC191B;
  grid-template-columns: auto 1fr;
  grid-template-rows: 0 1fr 50px;
  grid-template-areas:
    "sidenav header"
    "sidenav main"
    "sidenav footer";
  height: 100vh;
}

/* Give every child element its grid name */
.header {
  grid-area: header;
  background-color: #648ca6;
}

.sidenav {
  grid-area: sidenav;
  background-color: #394263;
}

.main {
  grid-area: main;
  background-color: #27282E;
}

 .main-header {
    display: flex;
    justify-content: space-between;
    margin: 20px;
    padding: 20px;
    height: 150px; /* Force our height since we don't have actual content yet */
    background-color: #e3e4e6;
    color: slategray;
  }

.footer {
  grid-area: footer;
  background-color: #648ca6;
}

  .sidenav {
    display: flex; /* Will be hidden on mobile */
    flex-direction: column;
    grid-area: sidenav;
    background-color: #394263;
  }

  .sidenav__list {
    padding: 0;
    margin-top: 85px;
    list-style-type: none;
  }

  .sidenav__list-item {
    padding: 20px 20px 20px 40px;
    color: #ddd;
  }

  .sidenav__list-item:hover {
    background-color: rgba(255, 255, 255, 0.2);
    cursor: pointer;
  }
  
  .main-overview {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(265px, 1fr)); /* Where the magic happens */
    grid-auto-rows: 94px;
    grid-gap: 20px;
    margin: 20px;
  }
  
  .overviewcard {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 20px;
    background-color: #161618;
    color: white;
  }
  
   .main-cards {
    column-count: 2;
    column-gap: 20px;
    margin: 20px;
  }
  
  .card {
    display: flex;
    flex-direction: column;
    align-items: center;
    width: 100%;
    background-color: white;
    margin-bottom: 20px;
    -webkit-column-break-inside: avoid;
    padding: 24px;
    box-sizing: border-box;
  }

  /* Force varying heights to simulate dynamic content */
  .card:first-child {
    height: 485px;
  }

  .card:nth-child(2) {
    height: 200px;
  }

  .card:nth-child(3) {
    height: 265px;
  }

  
  .main-cards {
    column-count: 1;
    column-gap: 20px;
    margin: 20px;
  }
  
  /* Medium-sized screen breakpoint (tablet, 1050px) */
  @media only screen and (min-width: 65.625em) {
    /* Break out main cards into two columns */
    .main-cards {
      column-count: 2;
    }
  }
</style>
</html>