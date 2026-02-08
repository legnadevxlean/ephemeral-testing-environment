import { Link } from 'react-router-dom'

function Home() {
    return (
        <div className="page home-page" data-testid="home-page">
            <header className="header">
                <h1 data-testid="home-title">Ephemeral QA Environment</h1>
            </header>

            <main className="main-content">
                <div className="hero">
                    <h2 data-testid="welcome-message">Welcome</h2>
                    <p>Demo application for automated E2E testing.</p>

                    <div className="features">
                        <div className="feature-card" data-testid="feature-ephemeral">
                            <span className="feature-icon">☁️</span>
                            <h3>Ephemeral Environment</h3>
                            <p>Deploy on demand, destroy after use</p>
                        </div>
                        <div className="feature-card" data-testid="feature-reports">
                            <span className="feature-icon">📊</span>
                            <h3>Test Reports</h3>
                            <p>Allure integration</p>
                        </div>
                    </div>

                    <Link to="/login" className="cta-button" data-testid="login-link">
                        Go to Login
                    </Link>
                </div>
            </main>

            <footer className="footer" data-testid="footer">
                <p>QA Demo App</p>
            </footer>
        </div>
    )
}

export default Home
