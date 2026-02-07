import { Link, useLocation, Navigate } from 'react-router-dom'

function Dashboard() {
    const location = useLocation()
    const user = location.state?.user

    if (!user) {
        return <Navigate to="/login" replace />
    }

    return (
        <div className="page dashboard-page" data-testid="dashboard-page">
            <header className="dashboard-header">
                <h1 data-testid="dashboard-title">Dashboard</h1>
                <Link to="/" className="logout-button" data-testid="logout-button">
                    Logout
                </Link>
            </header>

            <main className="dashboard-content">
                <div className="welcome-card" data-testid="welcome-card">
                    <h2 data-testid="welcome-message">Welcome back!</h2>
                    <p data-testid="user-email">Logged in as: <strong>{user}</strong></p>
                </div>

                <div className="success-message" data-testid="login-success-message">
                    ✓ You have successfully logged in!
                </div>
            </main>
        </div>
    )
}

export default Dashboard
