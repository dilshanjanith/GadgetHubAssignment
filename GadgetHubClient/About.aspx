<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="GadgetHubClient.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main aria-labelledby="title">
        <h2 id="title"><%:Title %>.</h2>
        <h3>Your application description page.</h3>
        <p>Use this area to provide additional information.</p>
    </main>
</asp:Content>
<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="GadgetHubClient.About" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        /* About Page Specific Styles */
        .about-container {
            animation:fadeIn 0.6s ease;
        }

        .hero-section {
            background:linear-gradient(135deg, rgba(22, 33, 62, 0.95), rgba(15, 52, 96, 0.95));
            backdrop-filter:blur(10px);
            border:1px solid #2d3561;
            border-radius:16px;
            padding:50px 40px;
            margin-bottom:40px;
            box-shadow:0 8px 32px rgba(0, 0, 0, 0.5);
            text-align:center;
        }

        .hero-section h2 {
            font-size:48px;
            background:linear-gradient(135deg, #e94560, #00d9ff);
            -webkit-background-clip:text;
            -webkit-text-fill-color:transparent;
            background-clip:text;
            margin-bottom:20px;
            font-weight:700;
        }

        .hero-section .tagline {
            font-size:24px;
            color:#aaa;
            margin-bottom:15px;
            font-weight:300;
        }

        .hero-section .description {
            font-size:16px;
            color:#bbb;
            line-height:1.8;
            max-width:800px;
            margin:0 auto;
        }

        .icon-large {
            font-size:80px;
            margin-bottom:20px;
            display:inline-block;
            animation:float 3s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform:translateY(0px); }
            50% { transform:translateY(-10px); }
        }

        /* Feature Cards */
        .features-section {
            margin:40px 0;
        }

        .features-grid {
            display:grid;
            grid-template-columns:repeat(auto-fit, minmax(300px, 1fr));
            gap:30px;
            margin-top:30px;
        }

        .feature-card {
            background:rgba(22, 33, 62, 0.9);
            backdrop-filter:blur(10px);
            border:1px solid #2d3561;
            border-radius:12px;
            padding:30px;
            box-shadow:0 8px 32px rgba(0, 0, 0, 0.4);
            transition:all 0.3s ease;
            animation:slideUp 0.6s ease;
        }

        .feature-card:hover {
            transform:translateY(-10px);
            box-shadow:0 12px 40px rgba(0, 217, 255, 0.2);
            border-color:#00d9ff;
        }

        .feature-icon {
            font-size:48px;
            margin-bottom:20px;
            display:inline-block;
        }

        .feature-card h3 {
            color:#00d9ff;
            font-size:22px;
            margin-bottom:15px;
            font-weight:600;
        }

        .feature-card p {
            color:#aaa;
            line-height:1.8;
            font-size:15px;
        }

        /* Stats Section */
        .stats-section {
            background:linear-gradient(135deg, rgba(233, 69, 96, 0.1), rgba(0, 217, 255, 0.1));
            border:1px solid #2d3561;
            border-radius:16px;
            padding:40px;
            margin:40px 0;
            box-shadow:0 8px 32px rgba(0, 0, 0, 0.4);
        }

        .stats-grid {
            display:grid;
            grid-template-columns:repeat(auto-fit, minmax(200px, 1fr));
            gap:30px;
            text-align:center;
        }

        .stat-item {
            padding:20px;
        }

        .stat-number {
            font-size:48px;
            font-weight:700;
            background:linear-gradient(135deg, #e94560, #00d9ff);
            -webkit-background-clip:text;
            -webkit-text-fill-color:transparent;
            background-clip:text;
            margin-bottom:10px;
        }

        .stat-label {
            color:#aaa;
            font-size:16px;
            text-transform:uppercase;
            letter-spacing:1px;
        }

        /* Team Section */
        .team-section {
            margin:40px 0;
        }

        .section-title {
            font-size:32px;
            color:#00d9ff;
            text-align:center;
            margin-bottom:40px;
            font-weight:600;
        }

        .team-grid {
            display:grid;
            grid-template-columns:repeat(auto-fit, minmax(250px, 1fr));
            gap:30px;
        }

        .team-card {
            background:rgba(22, 33, 62, 0.9);
            backdrop-filter:blur(10px);
            border:1px solid #2d3561;
            border-radius:12px;
            padding:30px;
            text-align:center;
            box-shadow:0 8px 32px rgba(0, 0, 0, 0.4);
            transition:all 0.3s ease;
        }

        .team-card:hover {
            transform:scale(1.05);
            border-color:#e94560;
            box-shadow:0 12px 40px rgba(233, 69, 96, 0.3);
        }

        .team-avatar {
            font-size:64px;
            margin-bottom:20px;
        }

        .team-name {
            color:#eee;
            font-size:20px;
            font-weight:600;
            margin-bottom:10px;
        }

        .team-role {
            color:#00d9ff;
            font-size:14px;
            text-transform:uppercase;
            letter-spacing:1px;
        }

        /* Technology Stack */
        .tech-section {
            background:rgba(22, 33, 62, 0.9);
            backdrop-filter:blur(10px);
            border:1px solid #2d3561;
            border-radius:16px;
            padding:40px;
            margin:40px 0;
            box-shadow:0 8px 32px rgba(0, 0, 0, 0.4);
        }

        .tech-grid {
            display:grid;
            grid-template-columns:repeat(auto-fit, minmax(150px, 1fr));
            gap:20px;
            margin-top:30px;
        }

        .tech-badge {
            background:rgba(15, 52, 96, 0.8);
            border:2px solid #2d3561;
            border-radius:8px;
            padding:20px;
            text-align:center;
            transition:all 0.3s ease;
        }

        .tech-badge:hover {
            border-color:#00d9ff;
            background:rgba(15, 52, 96, 1);
            transform:translateY(-5px);
        }

        .tech-badge span {
            font-size:32px;
            display:block;
            margin-bottom:10px;
        }

        .tech-badge p {
            color:#aaa;
            font-size:14px;
            margin:0;
            font-weight:600;
        }

        /* CTA Section */
        .cta-section {
            background:linear-gradient(135deg, #e94560, #d63350);
            border-radius:16px;
            padding:50px 40px;
            text-align:center;
            margin:40px 0;
            box-shadow:0 8px 32px rgba(233, 69, 96, 0.4);
        }

        .cta-section h3 {
            color:white;
            font-size:32px;
            margin-bottom:20px;
            font-weight:600;
        }

        .cta-section p {
            color:rgba(255, 255, 255, 0.9);
            font-size:18px;
            margin-bottom:30px;
        }

        .cta-button {
            background:white;
            color:#e94560;
            padding:15px 40px;
            border:none;
            border-radius:8px;
            font-size:16px;
            font-weight:600;
            text-transform:uppercase;
            letter-spacing:1px;
            cursor:pointer;
            transition:all 0.3s ease;
            text-decoration:none;
            display:inline-block;
        }

        .cta-button:hover {
            transform:translateY(-3px);
            box-shadow:0 8px 20px rgba(0, 0, 0, 0.3);
            background:#00d9ff;
            color:white;
        }

        /* Animations */
        @keyframes fadeIn {
            from {
                opacity:0;
                transform:translateY(20px);
            }
            to {
                opacity:1;
                transform:translateY(0);
            }
        }

        @keyframes slideUp {
            from {
                opacity:0;
                transform:translateY(30px);
            }
            to {
                opacity:1;
                transform:translateY(0);
            }
        }

        /* Responsive */
        @media (max-width:768px) {
            .hero-section {
                padding:30px 20px;
            }

            .hero-section h2 {
                font-size:32px;
            }

            .hero-section .tagline {
                font-size:18px;
            }

            .features-grid,
            .team-grid,
            .tech-grid {
                grid-template-columns:1fr;
            }
        }
    </style>

    <main aria-labelledby="title" class="about-container">
        <!-- Hero Section -->
        <section class="hero-section">
            <div class="icon-large">🎮</div>
            <h2 id="title">About GadgetHub</h2>
            <p class="tagline">Your Premium Technology Marketplace</p>
            <p class="description">
                GadgetHub is a cutting-edge e-commerce platform connecting customers with the latest gadgets 
                through our network of trusted distributors.We leverage Service-Oriented Architecture (SOA) 
                to deliver seamless quotations, competitive pricing, and exceptional service.
            </p>
        </section>

        <!-- Features Section -->
        <section class="features-section">
            <h2 class="section-title">Why Choose GadgetHub?</h2>
            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">🚀</div>
                    <h3>Lightning Fast</h3>
                    <p>
                        Instant quotation requests sent to multiple distributors simultaneously.
                        Get the best deals in seconds, not hours.
                    </p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">💰</div>
                    <h3>Best Prices</h3>
                    <p>
                        Compare quotes from TechWorld, ElectroCom, and Gadget Central.
                        Our AI-powered system recommends the optimal choice for you.
                    </p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">🔒</div>
                    <h3>Secure & Reliable</h3>
                    <p>
                        Enterprise-grade security with encrypted transactions.
                        Your data is protected with industry-leading standards.
                    </p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">📦</div>
                    <h3>Real-Time Tracking</h3>
                    <p>
                        Monitor your order status from quotation to delivery.
                        Stay informed with instant notifications at every step.
                    </p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">🎯</div>
                    <h3>Smart Recommendations</h3>
                    <p>
                        Our intelligent system analyzes price, stock, and delivery time 
                        to suggest the best distributor for your needs.
                    </p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">🌐</div>
                    <h3>SOA Architecture</h3>
                    <p>
                        Built on Service-Oriented Architecture for scalability, maintainability, 
                        and seamless integration with multiple distributors.
                    </p>
                </div>
            </div>
        </section>

        <!-- Stats Section -->
        <section class="stats-section">
            <div class="stats-grid">
                <div class="stat-item">
                    <div class="stat-number">3</div>
                    <div class="stat-label">Trusted Distributors</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">500+</div>
                    <div class="stat-label">Products Available</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">1000+</div>
                    <div class="stat-label">Happy Customers</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">99.9%</div>
                    <div class="stat-label">Uptime</div>
                </div>
            </div>
        </section>

        <!-- Technology Stack -->
        <section class="tech-section">
            <h2 class="section-title">Built With Modern Technology</h2>
            <div class="tech-grid">
                <div class="tech-badge">
                    <span>⚙️</span>
                    <p>ASP.NET</p>
                </div>
                <div class="tech-badge">
                    <span>🌐</span>
                    <p>SOAP Services</p>
                </div>
                <div class="tech-badge">
                    <span>💾</span>
                    <p>SQL Server</p>
                </div>
                <div class="tech-badge">
                    <span>🎨</span>
                    <p>Modern UI/UX</p>
                </div>
                <div class="tech-badge">
                    <span>🔐</span>
                    <p>Secure Auth</p>
                </div>
                <div class="tech-badge">
                    <span>📱</span>
                    <p>Responsive</p>
                </div>
            </div>
        </section>

        <!-- Team Section -->
        <section class="team-section">
            <h2 class="section-title">Meet Our Team</h2>
            <div class="team-grid">
                <div class="team-card">
                    <div class="team-avatar">👨‍💼</div>
                    <div class="team-name">Product Team</div>
                    <div class="team-role">Product Management</div>
                </div>
                <div class="team-card">
                    <div class="team-avatar">👩‍💻</div>
                    <div class="team-name">Development Team</div>
                    <div class="team-role">Software Engineering</div>
                </div>
                <div class="team-card">
                    <div class="team-avatar">🎨</div>
                    <div class="team-name">Design Team</div>
                    <div class="team-role">UI/UX Design</div>
                </div>
                <div class="team-card">
                    <div class="team-avatar">🤝</div>
                    <div class="team-name">Support Team</div>
                    <div class="team-role">Customer Success</div>
                </div>
            </div>
        </section>

        <!-- CTA Section -->
        <section class="cta-section">
            <h3>Ready to Experience the Future of Tech Shopping?</h3>
            <p>Join thousands of satisfied customers who trust GadgetHub for their technology needs.</p>
            <a href="Register.aspx" class="cta-button">Get Started Today</a>
        </section>
    </main>
</asp:Content>