package com.treeage.treeagepro.tutorials;

/**************************************************************************
 *   File: UseObjectInterface.java
 *
 *   Version 1.2
 *   Date            Author          Changes
 *   09.06.2010      Andrew Munzer   Created
 *   2015.06.15      Al Chrosny      Strategy Exclusion Sample
 *   2015.06.24      Al Chrosny      Saving RPTX example
 *
 *   Copyright (c) 2010 TreeAge Software, Inc.
 *   All rights reserved.
 ****************************************************************************/

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.rmi.RemoteException;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import com.treeage.treeagepro.oi.AnalysisType;
import com.treeage.treeagepro.oi.Distribution;
import com.treeage.treeagepro.oi.Node;
import com.treeage.treeagepro.oi.Report;
import com.treeage.treeagepro.oi.Status;
import com.treeage.treeagepro.oi.Tree;
import com.treeage.treeagepro.oi.TreeAgeProApplication;

@SuppressWarnings("unused")

// Class declaration
public class UseObjectInterface2 {

    private static java.lang.String sampleTreeOrig = "Example Models/Special Features/Excel/TreeWorkbookTest.trex";

    private static java.lang.String sampleTreeNew = "Example Models/Special Features/Excel/TreeWorkbookTest2.trex";

    private static java.lang.String ceSimTreeName2 = "Example Models/Healthcare/CE Markov Sampling.trex";
    
    private static java.lang.String simTreeName = "Example Models/Healthcare/Markov Monte Carlo 1.trex";
    
    private static java.lang.String ceSimTreeName = "Example Models/Healthcare/Monte Carlo C-E.trex";
    
    private static java.lang.String ceSimTreeName3 = "Example Models/Healthcare Training Examples/Example13-MicrosimulationPSA.trex";
    
    private boolean rollbackOn = false;
    
    private boolean outputReport = true;
    
    // Declare object for connecting to TreeAge Pro
    private TreeAgeProApplication app;

    /**
     * The default main method called on application start.
     * @param args
     */
    public static void main(java.lang.String[] args) {
        new UseObjectInterface2();
    }

    /**
     * Constructor for class UseObjectInterface.
     * 
     * Contains main tree processing.
     */
    private UseObjectInterface2() {

        com.treeage.treeagepro.oi.Tree sampleTree;
        com.treeage.treeagepro.oi.Tree ceSimTree;
        com.treeage.treeagepro.oi.Tree markovTree;

        // Connects locally to TreeAge Pro. 
        //   For connection to TreeAge Pro on a different computer use TreeAgeProApplication constructor with the host parameter (IP address)
        //   such as TreeAgeProApplication(host).
        app = new TreeAgeProApplication();
        if (!app.isValid()) {
            System.out.println("Cannot find TreeAge Pro application running locally.");
            return;
        }

        try {
        	// System.out.println will write text to TreeAge Pro console view.
            System.out.println("Workspace path: " + app.getWorkspacePath());
       
            // Open a sample tree. The path can be either absolute or relative
            // to workspace root folder.
            sampleTree = this.openTree(sampleTreeOrig);

            // Save under a new name. The path can be either absolute or
            // relative to workspace root folder.
            //sampleTree.saveAs(sampleTreeNew);

            // Output tree characteristics
            outputTreeInfo(sampleTree);

            // Read/update variables.
            updateVariable(sampleTree);

            // Update Distribution Parameters;
            updateDistributions(sampleTree);
//            
            // Analyze a simple tree and report results.
            analyzeEV(sampleTree);
            analyzeMC(sampleTree);
            analyzeCompDistrib(sampleTree);

            // Save changes to tree with new name.
            //sampleTree.saveAs(sampleTreeNew);

            // Open a CE simulation tree.
            ceSimTree = this.openTree(ceSimTreeName3);

            // It is possible to exclude strategies through code by using reference to the Node ID.
            // To see the Node ID for a strategy open NODE View and select the strategy node to be excluded.
            // Remove comment from the following two lines to exclude Node2 (first strategy RX-A in the model).
            // Node node2 = ceSimTree.getNodeById("Node2");
            // node2.setStrategyExcluded(true);

            // Output tree characteristics
            outputTreeInfo(ceSimTree);

            // Analyze a CE tree and report results.
            analyzeEV(ceSimTree); 
            analyzeMC(ceSimTree);
            
            markovTree = this.openTree(ceSimTreeName2);            
            
            // Output tree characteristics
            outputTreeInfo(markovTree);
            
            // Analyze markov tree and report results.
            analyzeMarkov(markovTree);
            
            sampleTree = this.openTree(ceSimTreeName2);
            
            // Output tree characteristics
            outputTreeInfo(sampleTree);
            
            // Analyze markov tree and report results.
            analyzeSensitivity(sampleTree);
            analyzeSensitivityMicrosim(sampleTree);
            analyzeSensitivityNetBen(sampleTree);
            analyzeSensitivity2Way(sampleTree);
            analyzeSensitivity3Way(sampleTree);
            analyzeTornado(sampleTree);
            // finally, refresh workspace elements
            app.refreshWorkspace();

        } catch (RemoteException re) {
            System.out.println("Failure in UseObjectInterface." + re.getLocalizedMessage());
        }
    }


	/**
     * Open a tree based on the filename argument.
     */
    private Tree openTree(java.lang.String fileName) throws RemoteException {

        try {
            Tree myTree = app.getTree(fileName);
            if (myTree.isValid()) {
                System.out.println("\nSuccessfully opened tree: " + myTree.getTreeName());
            } else {
                System.out.println("Could not open tree:" + fileName);
            }

            return myTree;
        } catch (RemoteException re) {
            System.out.println("Error trying to open tree:" + fileName);
            throw re;
        }

    }

    /**
     * Write tree information to the Console.
     */
    private void outputTreeInfo(Tree myTree) throws RemoteException {

        java.util.List<com.treeage.treeagepro.oi.Variable> varList;
        java.util.List<com.treeage.treeagepro.oi.Tracker> trackerList;
        java.util.List<com.treeage.treeagepro.oi.Table> tableList;
        java.util.List<com.treeage.treeagepro.oi.Distribution> distList;

        try {

            System.out.println("--- Outputting tree characteristics ---");
            System.out.println("File name: " + myTree.getFileName());
            System.out.println("Calculation method: " + myTree.getCalculationMethod());

            varList = myTree.getVariables();
            System.out.println("Variable count: " + varList.size());

            trackerList = myTree.getTrackers();
            System.out.println("Trackers count: " + trackerList.size());

            tableList = myTree.getTables();
            System.out.println("Tables count: " + tableList.size());

            distList = myTree.getDistributions();
            System.out.println("Distributions count: " + distList.size());

        } catch (RemoteException re) {
            System.out.println("Error outputting tree characteristics.");
            throw re;
        }

    }

    /**
     * Update a variable's properties. 
     * Update a variable definition at root node.
     */
    private void updateVariable(Tree myTree) throws RemoteException {

        com.treeage.treeagepro.oi.Variable myVar;
        com.treeage.treeagepro.oi.VariableDefinition myVarDef;

        try {

            System.out.println("--- Updating variable props and definition ---");

            myVar = myTree.getVariable("Variable01");
            System.out.println("Variable name current: " + myVar.getName());
            System.out.println("Variable desc current: " + myVar.getDescription());
            myVar.setDescription(myVar.getDescription() + " - updated by Object Interface");
            System.out.println("Variable desc new:     " + myVar.getDescription());

            myTree.getRoot();
            myVarDef = myVar.getRootDefinition();
            System.out.println("Variable def at root current: " + myVarDef.getValue());
            myVarDef.setValue(myVarDef.getValue() + " + 1");
            System.out.println("Variable def at root new:     " + myVarDef.getValue());
            myVar.setRootDefinition(myVarDef);

            myTree.updateVariable(myVar);

        } catch (RemoteException re) {
            System.out.println("Error updating variable and/or variable definition.");
            throw re;
        }

    }

    /**
     * Example of updating distribution parameters within a model.
     */
    private void updateDistributions(Tree sampleTree) throws RemoteException {

    	List<Distribution> dists = sampleTree.getDistributions();
        Map<String, String> distParams = new HashMap<String, String>();
        distParams.put("mean", "1,234.5");
        distParams.put("stddev", "76.543");
        // Change parameters for first distribution Index 1 in TreeAge equates to 0th element of the list.
        System.out.println(dists.get(0).getParametersMap().entrySet());
        dists.get(0).setParametersMap(distParams);            
        sampleTree.updateDistributions(dists);
	}
    
    private void analyzeCompDistrib(Tree myTree) throws RemoteException {
        try {
            Map<String, String> params = new HashMap<String, String>();
            com.treeage.treeagepro.oi.Report report;
            com.treeage.treeagepro.oi.Report expVal;
            Report secReport;
            System.out.println("Probability Distributions/Comparative Distributions");
            report = myTree.runAnalysis(AnalysisType.probDist, params, myTree.getRoot());
            saveReport(report, myTree);
            System.out.println("Text Report");
            secReport = report.createReport("compdist-txt", params);
            saveReport(secReport, myTree);
            /*
             //For Probability Distribution
            System.out.println("Text Report Bar Summary");
            secReport = report.createReport("probdist-histogram", params);
            saveReport(secReport, myTree);
            
            System.out.println("Text Report Bar Details");
            secReport = report.createReport("probdist-histogram-endnodes-txt", params);
            saveReport(secReport, myTree);
             */
        } catch (Exception e) {
            System.out.println("Error in analyzeTree. Regular exception, not RemoteException \n" + e.getMessage());
            return;
        }
    }
    
    private void analyzeSensitivity2Way(Tree myTree) throws RemoteException {
        try {
            Map<String, String> params = new HashMap<String, String>();
            com.treeage.treeagepro.oi.Report report;
            com.treeage.treeagepro.oi.Report expVal;
            Report secReport;
            params.put("1.variable", "cost");
            params.put("1.low", "0");
            params.put("1.high", "1");
            params.put("1.intervals", "4");
            params.put("1.defNodeId.1", "Node1");
            params.put("2.variable", "rate");
            params.put("2.low", "0");
            params.put("2.high", "0.5");
            params.put("2.intervals", "4");
            params.put("2.defNodeId.1", "Node1");
            params.put("willingnessToPay", "10"); //Not working            
            System.out.println("2 Way Sensitivity Analysis");
            report = myTree.runAnalysis(AnalysisType.sensitivity, params, myTree.getRoot());
            saveReport(report, myTree);
            System.out.println("Text Report");
            secReport = report.createReport("sensitivity-2way-text-ce", params);
            saveReport(secReport, myTree);
        } catch (Exception e) {
            System.out.println("Error in analyzeTree. Regular exception, not RemoteException \n" + e.getMessage());
            return;
        }
    }
    
    private void analyzeSensitivity3Way(Tree myTree) throws RemoteException {
        try {
            Map<String, String> params = new HashMap<String, String>();
            com.treeage.treeagepro.oi.Report report;
            com.treeage.treeagepro.oi.Report expVal;
            Report secReport;
            params.put("1.variable", "cost");
            params.put("1.low", "0");
            params.put("1.high", "1");
            params.put("1.intervals", "4");
            params.put("1.defNodeId.1", "Node1");
            params.put("2.variable", "rate");
            params.put("2.low", "0");
            params.put("2.high", "0.5");
            params.put("2.intervals", "4");
            params.put("2.defNodeId.1", "Node1");
            params.put("3.variable", "util");
            params.put("3.low", "0");
            params.put("3.high", "0.5");
            params.put("3.intervals", "4");
            params.put("3.defNodeId.1", "Node1");
            System.out.println("3 Way Sensitivity Analysis");
            report = myTree.runAnalysis(AnalysisType.sensitivity, params, myTree.getRoot());
            saveReport(report, myTree);
            System.out.println("Text Report");
            secReport = report.createReport("sensitivity-text-3way-CE-flat", params);
            saveReport(secReport, myTree);
            secReport = report.createReport("sens3wayXYisoChart-points", params);
            saveReport(secReport, myTree);
        } catch (Exception e) {
            System.out.println("Error in analyzeTree. Regular exception, not RemoteException \n" + e.getMessage());
            return;
        }
    }
    
    private void analyzeSensitivityNetBen(Tree myTree) throws RemoteException {
        try {
            Map<String, String> params = new HashMap<String, String>();
            com.treeage.treeagepro.oi.Report report;
            com.treeage.treeagepro.oi.Report expVal;
            Report secReport;
            params.put("1.variable", "cost");
            params.put("1.low", "0");
            params.put("1.high", "1");
            params.put("1.intervals", "4");
            params.put("1.defNodeId.1", "Node1");
            params.put("willingnessToPay","10");
            System.out.println("Net Ben Sensitivity Analysis");
            report = myTree.runAnalysis(AnalysisType.sensitivityNetBen, params, myTree.getRoot());
            saveReport(report, myTree);
            secReport = report.createReport("sensitivity-1way-NMB-text", params); //Not working
            saveReport(secReport, myTree);
            secReport = report.createReport("sensitivity-text-1way-NMB-thresholds", params); //Not working
            saveReport(secReport, myTree);

        } catch (Exception e) {
            System.out.println("Error in analyzeTree. Regular exception, not RemoteException \n" + e.getMessage());
            return;
        }
    } 
    
    private void analyzeTornado(Tree myTree) throws RemoteException {
        try {
            Map<String, String> params = new HashMap<String, String>();
            com.treeage.treeagepro.oi.Report report;
            com.treeage.treeagepro.oi.Report expVal;
            Report secReport;
            params.put("1.variable", "cost");
            params.put("1.low", "0");
            params.put("1.high", "1");
            params.put("1.intervals", "4");
            params.put("1.defNodeId.1", "Node1");
            params.put("2.variable", "rate");
            params.put("2.low", "0");
            params.put("2.high", "0.5");
            params.put("2.intervals", "4");
            params.put("2.defNodeId.1", "Node1");
            params.put("3.variable", "util");
            params.put("3.low", "0");
            params.put("3.high", "0.5");
            params.put("3.intervals", "4");
            params.put("3.defNodeId.1", "Node1");
            params.put("willingnessToPay", "10");
            System.out.println("Tornado analysis");
            report = myTree.runAnalysis(AnalysisType.tornado, params, myTree.getRoot()); //Not working
            saveReport(report, myTree);
        } catch (Exception e) {
            System.out.println("Error in analyzeTree. Regular exception, not RemoteException \n" + e.getMessage());
            return;
        }        
    }
    
    private void analyzeSensitivityMicrosim(Tree myTree) throws RemoteException {
        try {
            Map<String, String> params = new HashMap<String, String>();
            com.treeage.treeagepro.oi.Report report;
            com.treeage.treeagepro.oi.Report expVal;
            Report secReport;
            params.put("variable", "cost");
            params.put("low", "0");
            params.put("high", "1");
            params.put("intervals", "4");
            params.put("defNodeId.1", "Node1");
            params.put("runMicrosimulation", "true");
            params.put("isNetBenefits", "true");
            params.put("trials", "100");
            System.out.println("Run microsimulation sensitivity analysis");
            report = myTree.runAnalysis(AnalysisType.sensitivity, params, myTree.getRoot());
            saveReport(report, myTree);
        } catch (Exception e) {
            System.out.println("Error in analyzeTree. Regular exception, not RemoteException \n" + e.getMessage());
            return;
        }
    }
    
    
    private void analyzeSensitivity(Tree myTree) throws RemoteException {
        try {
            Map<String, String> params = new HashMap<String, String>();
            com.treeage.treeagepro.oi.Report report;
            com.treeage.treeagepro.oi.Report expVal;
            Report secReport;
            params.put("variable", "cost");
            params.put("low", "0");
            params.put("high", "1");
            params.put("intervals", "4");
            params.put("defNodeId.1", "Node1");
            System.out.println("Run 1-way sensitivity analysis");
            report = myTree.runAnalysis(AnalysisType.sensitivity, params, myTree.getRoot());            
            saveReport(report, myTree);
            
            
            if (myTree.getCalculationMethod().equals("ct_simple")) {                
                secReport = report.createReport("sensitivity-text-1way", params);
                saveReport(secReport, myTree);
                return;
            }
            
            System.out.println("Cost-Effectiveness (animated)");
            secReport = report.createReport("sensitivity-1way-CE-anim", params);
            saveReport(secReport, myTree);
            
            System.out.println("Cost-Effectiveness (animated, axe inverted)");
            secReport = report.createReport("sensitivity-1way-CE-anim-inv", params);
            saveReport(secReport, myTree);
            
            System.out.println("Cost vs Avg Cost");
            secReport = report.createReport("sensitivity-1way-CE-AC-chart", params);
            saveReport(secReport, myTree);
            
            System.out.println("Cost vs Avg Cost Text");
            secReport = report.createReport("sensitivity-1way-CE-AC-text", params);
            
            System.out.println("Cost vs Incremental Cost");
            secReport = report.createReport("sensitivity-1way-CE-IC-chart", params);
            saveReport(secReport, myTree);
            
            System.out.println("Cost vs Incremental Text");
            secReport = report.createReport("sensitivity-1way-CE-IC-text", params);
            saveReport(secReport, myTree);
            
            System.out.println("Cost vs Avg Effectiveness");
            secReport = report.createReport("sensitivity-1way-CE-AE-chart", params);
            saveReport(secReport, myTree);
            
            System.out.println("Cost vs Avg Effectiveness");
            secReport = report.createReport("sensitivity-1way-CE-AE-text", params);
            saveReport(secReport, myTree);

            System.out.println("Cost vs Incremental Effectiveness");
            secReport = report.createReport("sensitivity-1way-CE-IE-chart", params);
            saveReport(secReport, myTree);
            
            System.out.println("Cost vs Incremental Effectiveness Text");
            secReport = report.createReport("sensitivity-1way-CE-IE-text", params);
            saveReport(secReport, myTree);
            
            System.out.println("Cost vs ICER (Incremental C-E)");
            secReport = report.createReport("sensitivity-1way-CE-ICE-chart", params);
            saveReport(secReport, myTree);
            
            System.out.println("Cost vs ICER (Incremental C-E) Text");
            secReport = report.createReport("sensitivity-1way-CE-ICE-text", params);
            saveReport(secReport, myTree);
            
            System.out.println("Cost vs Avg C-E");
            secReport = report.createReport("sensitivity-1way-CE-CE-chart", params); 
            saveReport(secReport, myTree);
            
            System.out.println("Cost vs Avg C-E Text");
            secReport = report.createReport("sensitivity-1way-CE-CE-text", params); 
            saveReport(secReport, myTree);
            
        } catch (Exception e) {
            System.out.println("Error in analyzeTree. Regular exception, not RemoteException \n" + e.getMessage());
            return;
        }
    }
    
    private void analyzeMarkov(Tree myTree) throws RemoteException {        
        try {
            Map<String, String> params = new HashMap<String, String>();;
            com.treeage.treeagepro.oi.Report report;
            com.treeage.treeagepro.oi.Report expVal;
            params.put("tunnelCollapse", "0");
            params.put("OIDecimalDigits", "4");
            Node node = myTree.getNodeById("Node2"); 
            report = myTree.runAnalysis(AnalysisType.markov, params, node);
            if(report.getStatus() == com.treeage.treeagepro.oi.Status.ERROR) {
                System.out.println("Markov Analysis Failed: " + report.getStatus().getDescription());    
            }
            saveReport(report, myTree); 
            Report secReport;
            System.out.println("Summary Report");
            if (myTree.getCalculationMethod().equals("ct_simple")) {                
                secReport = report.createReport("markov-cohort-summary", params);            
            }  else {
                secReport = report.createReport("markov-cohort-summary-CE", params);
            }
            saveReport(secReport, myTree);
            
            
            System.out.println("State Prob");
            secReport = report.createReport("markov-graph-state-probability", params);
            saveReport(secReport, myTree);

            System.out.println("Survival Curve");
            secReport = report.createReport("markov-graph-survival", params);
            saveReport(secReport, myTree);

            if (myTree.getCalculationMethod().equals("ct_simple")) {
                System.out.println("State Reward");
                secReport = report.createReport("markov-graph-state-reward", params);
                saveReport(secReport, myTree);

                System.out.println("Stage Reward");
                secReport = report.createReport("markov-graph-stage-reward", params);
                saveReport(secReport, myTree);

                System.out.println("Total Reward");
                secReport = report.createReport("markov-graph-total-reward", params);
                saveReport(secReport, myTree);
            } else {
                System.out.println("Stage Cost");
                secReport = report.createReport("markov-graph-stage-cost", params);
                saveReport(secReport, myTree);

                System.out.println("Stage Effectiveness");
                secReport = report.createReport("markov-graph-stage-effectiveness", params);
                saveReport(secReport, myTree);

                System.out.println("Cumulative Cost");
                secReport = report.createReport("markov-graph-total-cost", params);
                saveReport(secReport, myTree);

                System.out.println("Cumulative Effectiveness");
                secReport = report.createReport("markov-graph-total-effectiveness", params);
                saveReport(secReport, myTree);
            }
            
        } catch (RemoteException re) {
            System.out.println("Error in analyzeTree.");
            throw re;
        } catch (Exception e) {
            System.out.println("Error in analyzeTree. Regular exception, not RemoteException \n" + e.getMessage());
            return;
        }
        
    }
    
    private void analyzeEV(Tree myTree) throws RemoteException {
        com.treeage.treeagepro.oi.Node myNode;
        com.treeage.treeagepro.oi.Node stratNode;
        Map<String, String> params;
        com.treeage.treeagepro.oi.Report report;
        com.treeage.treeagepro.oi.Report expVal;
        com.treeage.treeagepro.oi.Graph ceGraph;
        java.lang.String nodePath;

        try {

            System.out.println("--- Running roll back and getting EV for each strategy ---");
            if(rollbackOn) {
                // Turn rollback on
                params = Collections.singletonMap("enable", "true");
                System.out.println("************************************************");
                System.out.println("--- Running Roll Back analysis ---");
                System.out.println("Model: " + myTree.getFileName());
                report = myTree.runAnalysis(AnalysisType.rollback, params, null);

                // Get expected values at the root node.
                myNode = myTree.getRoot();
                expVal = myNode.expVal();
                if (myTree.getCalculationMethod().equals("ct_costEff")) {
                    System.out.println("Val at root node: ");
                    System.out.println("  Cost: " + expVal.getValue("cost"));
                    System.out.println("  Eff:  " + expVal.getValue("effectiveness"));
                } else {
                    System.out.println("Val at root node: " + expVal.getValue("expectedValue"));
                }

                // Cycle through strategy nodes and collect expected values for each strategy
                for (int i = 1; i <= myNode.getBranchesNumber(); ++i) {

                    nodePath = "$" + i;
                    stratNode = myNode.getRelativeNode(nodePath);
                    expVal = stratNode.expVal();
                    if (myTree.getCalculationMethod().equals("ct_costEff")) {
                        System.out.println("Val at node '" + stratNode.getLabel() + "': ");
                        System.out.println("  Cost: " + expVal.getValue("cost"));
                        System.out.println("  Eff:  " + expVal.getValue("effectiveness"));
                    } else {
                        System.out.println("Val at node '" + stratNode.getLabel() + "': " + expVal.getValue("expectedValue"));
                    }

                }

                // Turn rollback off
                params = Collections.singletonMap("enable", "false");
                report = myTree.runAnalysis(AnalysisType.rollback, params, null);
            }
            
            myNode = myTree.getRoot();

            // Run cost-effectiveness analysis on CE tree
            if (myTree.getCalculationMethod().equals("ct_costEff")) {
                System.out.println("************************************************");
                System.out.println("--- Running Cost-Effectiveness analysis ---");
                System.out.println("Model: " + myTree.getFileName());
                report = myTree.runAnalysis(AnalysisType.costEffectivenes, null, myNode);
                System.out.println("CE text report");
                System.out.println("CEA graph");
                saveReport(report, myTree);                    
                
            }
        } catch (RemoteException re) {
            System.out.println("Error in analyzeTree.");
            throw re;
        } catch (Exception e) {
            System.out.println("Error in analyzeTree. Regular exception, not RemoteException \n" + e.getMessage());
            return;
        }
    }
    
    
    /**
     * Analyze the tree...
     * - Run simulation (PSA for CE tree, trials for simple tree.
     */
    private void analyzeMC(Tree myTree) throws RemoteException {

        com.treeage.treeagepro.oi.Node myNode;
        com.treeage.treeagepro.oi.Node stratNode;
        Map<String, String> params;
        com.treeage.treeagepro.oi.Report report;
        com.treeage.treeagepro.oi.Report expVal;
        com.treeage.treeagepro.oi.Graph ceGraph;
        java.lang.String nodePath;

        try {
            myNode = myTree.getRoot();
            System.out.println("************************************************");
            System.out.println("--- Running Monte Carlo simulation ---");
            System.out.println("Model: " + myTree.getFileName());

            // Setup simulation parameters, several just use default
            // Run PSA on this specific CE tree, trials on the sample tree
            params = new HashMap<String, String>();
            params.put("voiSamples", "0");
            params.put("runParallelTrials", "0");
            params.put("numParallelSets", "0");
            params.put("OIDecimalDigits", "5");
            params.put("OIUseTreePreferenceFormatting", "true");
            if (myTree.getCalculationMethod().equals("ct_costEff")) {
                params.put("samples", "100");
                params.put("trials", "0");
            } else {
                params.put("samples", "0");
                params.put("trials", "100");
            }

            report = myTree.runAnalysis(AnalysisType.monteCarlo, params, myNode);
            /**Data reports*/
            System.out.println("Simulation complete. Calc time: " + report.getCalcTime() + ", Status: " + report.getStatus());
            saveReport(report, myTree);

            System.out.println("Monte Carlo All Data Report");
            Report secReport = report.createReport("montecarlo-all-values-union-text", params); 
            saveReport(secReport, myTree);            
            System.out.println("Monte Carlo Summary Report");
            secReport = report.createReport("montecarlo-all-stats-union-text", params); 
            saveReport(secReport, myTree);          
                       
            /**Other reports*/
            System.out.println("Expected Values");
            secReport = report.createReport("montecarlo-all-evs-union-text", params);
            saveReport(secReport, myTree);       
            System.out.println("Monte Carlo Identifying Variables");
            secReport = report.createReport("montecarlo-identifiers-text", params);
            saveReport(secReport, myTree);
            
            System.out.println("Monte Carlo Distributions Text Report");
            report = report.createReport("montecarlo-distsamplers-text", params);
            saveReport(report, myTree);            
            System.out.println("Monte Carlo Distributions Report");
            secReport = report.createReport("montecarlo-all-dists-text", params);
            saveReport(secReport, myTree);
            System.out.println("Monte Carlo Trackers Text Report");
            secReport = report.createReport("montecarlo-trackers-text", params);
            saveReport(secReport, myTree);
            System.out.println("Monte Carlo Trackers Report");
            secReport = report.createReport("montecarlo-all-trackers-text", params);
            saveReport(secReport, myTree);
            System.out.println("Monte Carlo Extras Text Report");
            secReport = report.createReport("montecarlo-extras-text", params); 
            saveReport(secReport, myTree);
            System.out.println("Monte Carlo Extra Payoffs Report");
            secReport = report.createReport("montecarlo-all-extra-payoffs-text", params);
            saveReport(secReport, myTree);
            if(myTree.getCalculationMethod().equals("ct_simple")) { 
                System.out.println("Acceptability at WTP");
                secReport = report.createReport("montecarlo-strategy-chart", params);
                saveReport(secReport, myTree);
                System.out.println("EVPI/EVPPI Summary Report");
                secReport = report.createReport("montecarlo-EVPI-summary-text", params);
                saveReport(secReport, myTree);
            }
            if(params.get("trials") != null && !params.get("trials").equals("0")) {
                System.out.println("Histograms\\Tracker distributions");
                params.put("Tracker", "Tracker1");
                params.put("strategy", "1");
                secReport = report.createReport("montecarlo-probdist", params); 
                saveReport(secReport, myTree, "_Tracker_dists_");    
            }
                        
            /***
             * CE Reports
             */
            if (!myTree.getCalculationMethod().equals("ct_costEff")) {
                return;
            }
            params.put("willingnessToPay", "50000");
            params.put("startIteration", "1");
            params.put("endIteration", "100");
            System.out.println("EVPI/EVPPI Summary Report");
            secReport = report.createReport("montecarlo-EVPI-summary-text-CE", params); 
            saveReport(secReport, myTree);
            
            System.out.println("EVPI/EVPPI Details");
            secReport = secReport.createReport("montecarlo-EVPI-text-CE", params); 
            saveReport(secReport, myTree);
            
            params.put("willingnessToPayLow", "0");
            params.put("willingnessToPayHigh", "100000");
            params.put("willingnessToPayIntervals", "10");
            System.out.println("EVPI vs. WTP Report");
            secReport = report.createReport("montecarlo-evpi-vs-wtp", params); 
            saveReport(secReport, myTree);
            
            System.out.println("EVPI vs. WTP Text Report");
            secReport = secReport.createReport("montecarlo-evpi-vs-wtp-text", params); 
            saveReport(secReport, myTree);


            String imgDir = app.getWorkspacePath() + "/Example Models/Healthcare/"; 
            //  Incremental Cost-Effectiveness
            System.out.println("Strategies Map: " + report.getValue("strategiesMap"));
            Map<String, String> iceParams = new HashMap<String, String>();
            iceParams.put("willingnessToPay", "50000");
            iceParams.put("strategy1", "1");
            iceParams.put("strategy2", "2");
            System.out.println("MC ICE Scatterplot chart");
            Report iceReport = report.createReport("montecarlo-ICE-scatter-chart", iceParams);            
            saveReport(iceReport, myTree);
            System.out.println("MC ICE Scatterplot text");
            iceReport = report.createReport("montecarlo-ICE-scatter-text", iceParams);            
            saveReport(iceReport, myTree);
            //  Acceptability Curve
            
            Map<String, String> acParams = new HashMap<String, String>();
            acParams.put("willingnessToPayLow", "0");
            acParams.put("willingnessToPayHigh", "50000");
            acParams.put("startIteration", "1");
            acParams.put("endIteration", "100");
            System.out.println("MC Acceptability Curve chart");
            Report acReport = report.createReport("montecarlo-CEAC-chart", acParams);
            saveReport(acReport, myTree);
            System.out.println("MC Acceptability Curve chart/text");
            acReport = report.createReport("montecarlo-CEAC-chart-text", acParams); //Not working
            saveReport(acReport, myTree);
            //  Strategy Selection
            Map<String, String> ssParams = new HashMap<String, String>();
            ssParams.put("willingnessToPay", "50000");
            ssParams.put("startIteration", "1");
            ssParams.put("endIteration", "100");
            System.out.println("MC Strategy Selection chart");
            Report ssReport = report.createReport("montecarlo-CE-strategy-chart", ssParams);
            saveReport(ssReport, myTree);
            System.out.println("ICER Distributions (Different strategy pairings)");
            params.put("baseline", "1");
            params.put("comparator", "2");
            secReport = report.createReport("montecarlo-probdist", params);
            saveReport(secReport, myTree, "_ICER_"); 
            System.out.println("ICER Distributions (Different strategy pairings) Text Report");
            secReport = report.createReport("montecarlo-probdist-text", params); 
            saveReport(secReport, myTree, "_ICER_");
            System.out.println("ICER Distributions (Different strategy pairings) Dist Statistics");
            secReport = report.createReport("montecarlo-probdist-stats", params); 
            saveReport(secReport, myTree, "_ICER_");
            System.out.println("Monte Carlo NMB v. WTP");
            params.put("willingnessToPayLow", "0");
            params.put("willingnessToPayHigh", "50000");
            params.put("willingnessToPayIntervals", "10");
            secReport = report.createReport("montecarlo-nmb-vs-wtp", params); 
            saveReport(secReport, myTree);
            System.out.println("INMB v. WTP (Different strategy pairings)");
            params.put("baseline", "1");
            params.put("comparator", "2");
            secReport = report.createReport("montecarlo-inmb-vs-wtp", params);  
            saveReport(secReport, myTree);
            System.out.println("Monte Carlo CE Plot");
            secReport = report.createReport("montecarlo-cost-effect-chart", params);
            saveReport(secReport, myTree);
            System.out.println("Monte Carlo CE Rankings Report");
            secReport = report.createReport("montecarlo-cost-effect-txt", params);
            saveReport(secReport, myTree);            
            System.out.println("Monte Carlo CE Plot Inverted");
            secReport = report.createReport("montecarlo-cost-effect-chart-inv", params);
            saveReport(secReport, myTree);
            //  Cost-Effectiveness Scatterplot
            System.out.println("Monte Carlo CE Scatterplot");
            Report scatterReport = report.createReport("montecarlo-CE-scatter-chart", params);
            saveReport(scatterReport, myTree);
            System.out.println("Monte Carlo CE Scatterplot Text report");
            scatterReport = report.createReport("montecarlo-CE-scatter-text", params);
            saveReport(scatterReport, myTree);
            System.out.println("Java OI example completed");
        } catch (RemoteException re) {
            System.out.println("Error in analyzeTree.");
            throw re;
        } catch (Exception e) {
            System.out.println("Error in analyzeTree. Regular exception, not RemoteException \n" + e.getMessage());
            return;
        }
    }
    
    private void saveReport(com.treeage.treeagepro.oi.Report report, Tree myTree) {
        saveReport(report, myTree, "");
    }
    
    /**
     *  Saves report as RPTX, additionaly graph report is saved as image file, text report is saved as txt file.     
     * */ 
    private void saveReport(com.treeage.treeagepro.oi.Report report, Tree myTree, String suffix) {
        try {
            String workspaceSubfolder = "/Other Projects/Output/";
            Map<String, String> params = new HashMap<String, String>();
            if (report.getStatus() == Status.OK) {
                params.put(Report.RPTX_FILENAME, app.getWorkspacePath() + workspaceSubfolder + adaptFilename(myTree.getTreeName()) + "_" + report.getReportId() + suffix + ".rptx");
                System.out.println("Save report, ID: " + report.getReportId());
                report.saveAsRptx(params);
                if(outputReport) {
                    System.out.println("Output text report, ID: " + report.getReportId() + ", File: " +myTree.getTreeName());
                    outputTextReportToFile(report.getTextReport(), app.getWorkspacePath() + workspaceSubfolder + adaptFilename(myTree.getTreeName()) + "_" + report.getReportId() + suffix + ".txt");
                }
                if (report.getGraph() != null) {
                    String imgDir = app.getWorkspacePath() + workspaceSubfolder;
                    String ssImg = imgDir + adaptFilename(myTree.getTreeName()) + "_" + report.getReportId() + suffix + ".png" ;
                    report.getGraph().saveAsImage(ssImg);
                    System.out.println("Chart image file is: " + ssImg);
                }
            } else {
                System.out.println("Simulation failed with the following error message: \n" + report.getMessage());
                System.out.println("Report with ID " + report.getReportId() + " Status: " +report.getStatus().getDescription());
            }
            System.out.println("");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static String adaptFilename(String s) {
        String separator = System.getProperty("file.separator");
        String filename;

        // Remove the path upto the filename.
        int lastSeparatorIndex = s.lastIndexOf(separator);
        if (lastSeparatorIndex == -1) {
            filename = s;
        } else {
            filename = s.substring(lastSeparatorIndex + 1);
        }
        // Remove the extension.
        int extensionIndex = filename.lastIndexOf(".");
        if (extensionIndex == -1) {
            return filename;
        }
        return filename.substring(0, extensionIndex).replace(" ", "_");
    }
    
    /**
     * Output text report to the console
     */
    private void outputTextReport(com.treeage.treeagepro.oi.TextReport txtRpt) throws RemoteException {
        if (txtRpt == null) {
            return;
        }
        java.util.List<java.lang.String> headers;
        java.util.List<java.util.List<java.lang.String>> rows;
        java.util.List<java.lang.String> cols;

        headers = txtRpt.getHeaders();
        for (int h = 0; h < headers.size(); ++h) {
            System.out.print(headers.get(h) + "\t");
        }
        System.out.println("");

        rows = txtRpt.getRows();
        for (int i = 0; i < rows.size(); ++i) {
            cols = rows.get(i);
            for (int j = 0; j < cols.size(); ++j) {
                System.out.print(cols.get(j) + "\t");
            }
            System.out.println("");
        }
    }
    
    private void outputTextReportToFile(com.treeage.treeagepro.oi.TextReport txtRpt, String filename) {
        try {
            if (txtRpt == null) {
                return;
            }
            BufferedWriter writer = new BufferedWriter(new FileWriter(filename));
            java.util.List<java.lang.String> headers;
            java.util.List<java.util.List<java.lang.String>> rows;
            java.util.List<java.lang.String> cols;

            headers = txtRpt.getHeaders();
            for (int h = 0; h < headers.size(); ++h) {
                writer.write(headers.get(h) + "\t");
            }
            writer.newLine();

            rows = txtRpt.getRows();
            for (int i = 0; i < rows.size(); ++i) {
                cols = rows.get(i);
                for (int j = 0; j < cols.size(); ++j) {
                    writer.write(cols.get(j) + "\t");
                }
                writer.newLine();
            }
            writer.flush();
            writer.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
}
