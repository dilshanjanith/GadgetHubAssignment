<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default. aspx.cs" Inherits="GadgetHubClient._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        /* Hero Section */
        .hero-section {
            background:linear-gradient(135deg, rgba(233, 69, 96, 0.1), rgba(0, 217, 255, 0.1));
            border:1px solid #2d3561;
            border-radius: 16px;
            padding:60px 40px;
            text-align:center;
            margin-bottom:50px;
            box-shadow:0 8px 32px rgba(0, 0, 0, 0.4);
            animation:fadeIn 0.6s ease;
        }

        .hero-icon {
            font-size:80px;
            margin-bottom:20px;
            animation:float 3s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform:translateY(0px); }
            50% { transform:translateY(-10px); }
        }

        . hero-section h1 {
            font-size:56px;
            background:linear-gradient(135deg, #e94560, #00d9ff);
            -webkit-background-clip:text;
            -webkit-text-fill-color:transparent;
            background-clip:text;
            margin-bottom:20px;
            font-weight:700;
        }

        .hero-section .lead {
            font-size:20px;
            color:#aaa;
            max-width:800px;
            margin:0 auto 30px;
            line-height:1.8;
        }

        .btn-hero {
            background:linear-gradient(135deg, #e94560, #d63350);
            color:white;
            padding:15px 40px;
            border:none;
            border-radius:8px;
            font-size:18px;
            font-weight:600;
            text-transform:uppercase;
            letter-spacing:1px;
            text-decoration:none;
            display:inline-block;
            transition:all 0.3s ease;
            box-shadow:0 6px 20px rgba(233, 69, 96, 0.3);
        }

        .btn-hero:hover {
            transform:translateY(-3px);
            box-shadow:0 8px 25px rgba(233, 69, 96, 0.5);
            text-decoration: none;
            color:white;
        }

        /* Feature Cards */
        .features-row {
            display:grid;
            grid-template-columns:repeat(auto-fit, minmax(300px, 1fr));
            gap:30px;
            margin-top:40px;
        }

        .feature-card {
            background:rgba(22, 33, 62, 0.9);
            backdrop-filter:blur(10px);
            border:1px solid #2d3561;
            border-radius:12px;
            padding:35px;
            box-shadow:0 8px 32px rgba(0, 0, 0, 0.4);
            transition:all 0.3s ease;
            animation:slideUp 0.6s ease;
        }

        .feature-card:hover {
            transform:translateY(-10px);
            border-color:#00d9ff;
            box-shadow:0 12px 40px rgba(0, 217, 255, 0.3);
        }

        .feature-icon {
            font-size: 48px;
            margin-bottom:20px;
            display:block;
        }

        .feature-card h2 {
            color:#00d9ff;
            font-size:24px;
            margin-bottom:15px;
            font-weight:600;
        }

        .feature-card p {
            color:#aaa;
            line-height:1.8;
            margin-bottom:20px;
            font-size:15px;
        }

        .btn-feature {
            background:rgba(0, 217, 255, 0.1);
            border:2px solid #00d9ff;
            color:#00d9ff;
            padding:10px 25px;
            border-radius:6px;
            text-decoration:none;
            font-weight: 600;
            font-size: 14px;
            transition:all 0.3s ease;
            display:inline-block;
        }

        .btn-feature:hover {
            background:#00d9ff;
            color:#1a1a2e;
            text-decoration:none;
            transform:translateX(5px);
        }

        /* Quick Links Section */
        .quick-links {
            background:rgba(22, 33, 62, 0.9);
            border:1px solid #2d3561;
            border-radius:12px;
            padding:40px;
            margin-top: 50px;
            text-align:center;
            box-shadow:0 8px 32px rgba(0, 0, 0, 0.4);
        }

        . quick-links h3 {
            color:#eee;
            font-size:28px;
            margin-bottom:30px;
            font-weight:600;
        }

        .link-buttons {
            display:flex;
            justify-content:center;
            gap:20px;
            flex-wrap:wrap;
        }

        .link-btn {
            background:linear-gradient(135deg, #0f3460, #1e3a5f);
            border:1px solid #2d3561;
            color:#eee;
            padding:15px 30px;
            border-radius:8px;
            text-decoration:none;
            font-weight:600;
            transition:all 0.3s ease;
            box-shadow:0 4px 12px rgba(0, 0, 0, 0.3);
        }

        .link-btn:hover {
            transform:translateY(-3px);
            border-color:#00d9ff;
            color:#00d9ff;
            box-shadow: 0 6px 20px rgba(0, 217, 255, 0.3);
            text-decoration:none;
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
                padding:40px 20px;
            }

            .hero-section h1 {
                font-size:36px;
            }

            .hero-section .lead {
                font-size:16px;
            }

            .features-row {
                grid-template-columns:1fr;
            }

            .link-buttons {
                flex-direction: column;
            }

            .link-btn {
                width:100%;
            }
        }
    </style>

    <main>
        <!-- Hero Section -->
        <section class="hero-section">
            <div class="hero-icon">🎮</div>
            <h1>Welcome to GadgetHub</h1>
            <p class="lead">
                Your premier destination for the latest gadgets and technology.  
                We connect you with top distributors to get the best prices, fastest delivery, and exceptional service.
            </p>
            <a href="ProductForm. aspx" class="btn-hero">Start Shopping →</a>
        </section>

        <!-- Feature Cards -->
        <div class="features-row">
            <section class="feature-card">
                <span class="feature-icon">⚡</span>
                <h2>Instant Quotations</h2>
                <p>
                    Get real-time quotes from multiple distributors simultaneously.
                    Our SOA-based system compares prices, availability, and delivery times 
                    to find you the best deal in seconds.
                </p>
                <a href="About.aspx" class="btn-feature">Learn More →</a>
            </section>

            <section class="feature-card">
                <span class="feature-icon">💎</span>
                <h2>Best Prices Guaranteed</h2>
                <p>
                    We work with TechWorld, ElectroCom, and Gadget Central to ensure 
                    you always get competitive pricing. Our smart system automatically 
                    recommends the best option for your needs.
                </p>
                <a href="ProductForm.aspx" class="btn-feature">View Products →</a>
            </section>

            <section class="feature-card">
                <span class="feature-icon">🚀</span>
                <h2>Fast & Reliable</h2>
                <p>
                    Track your orders in real-time from quotation to delivery.  
                    Our service-oriented architecture ensures scalability, reliability, 
                    and lightning-fast performance even during peak times.
                </p>
                <a href="Contact.aspx" class="btn-feature">Contact Us →</a>
            </section>
        </div>

        <!-- Quick Links -->
        <section class="quick-links">
            <h3>🌟 Quick Access</h3>
            <div class="link-buttons">
                <a href="Login.aspx" class="link-btn">🔐 Customer Login</a>
                <a href="DistributorLogin.aspx" class="link-btn">🚚 Distributor Portal</a>
                <a href="Register.aspx" class="link-btn">📝 Create Account</a>
                <a href="About.aspx" class="link-btn">ℹ️ About Us</a>
            </div>
        </section>
    </main>
</asp:Content>