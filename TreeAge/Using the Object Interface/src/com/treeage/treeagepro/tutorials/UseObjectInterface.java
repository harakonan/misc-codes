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
package com.treeage.treeagepro.tutorials;

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

/**
 * This example uses Object Interface for Java to remotely connect to TreeAge Pro.
 * 
 * @author Andrew Munzer
 * @version 1.0 11.06.2010
 * 
 * @author achrosny
 * @version 1.1 2015.04.08
 * 
 * Added distribution parameter updates.
 * 
 * @author achrosny
 * @version 1.2 2015.06.15
 * 
 * Added example of excluding strategies.

 */
@SuppressWarnings("unused")

// Class declaration
public class UseObjectInterface {

    private static java.lang.String sampleTreeOrig = "Example Models/Special Features/Excel/TreeWorkbookTest.trex";

    private static java.lang.String sampleTreeNew = "Example Models/Special Features/Excel/TreeWorkbookTest2.trex";

    private static java.lang.String ceSimTreeName = "Example Models/Healthcare/CE Markov Sampling.trex";

    // Declare object for connecting to TreeAge Pro
    private TreeAgeProApplication app;

    /**
     * The default main method called on application start.
     * @param args
     */
    public static void main(java.lang.String[] args) {
        new UseObjectInterface();
    }

    /**
     * Constructor for class UseObjectInterface.
     * 
     * Contains main tree processing.
     */
    private UseObjectInterface() {

        com.treeage.treeagepro.oi.Tree sampleTree;
        com.treeage.treeagepro.oi.Tree ceSimTree;

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
            sampleTree.saveAs(sampleTreeNew);

            // Output tree characteristics
            outputTreeInfo(sampleTree);

            // Read/update variables.
            updateVariable(sampleTree);

            // Update Distribution Parameters;
            updateDistributions(sampleTree);
            
            // Analyze a simple tree and report results.
            analyzeTree(sampleTree);

            // Save changes to tree with new name.
            sampleTree.saveAs(sampleTreeNew);

            // Open a CE simulation tree.
            ceSimTree = this.openTree(ceSimTreeName);

            // It is possible to exclude strategies through code by using reference to the Node ID.
            // To see the Node ID for a strategy open NODE View and select the strategy node to be excluded.
            // Remove comment from the following two lines to exclude Node2 (first strategy RX-A in the model).
            // Node node2 = ceSimTree.getNodeById("Node2");
            // node2.setStrategyExcluded(true);

            // Output tree characteristics
            outputTreeInfo(ceSimTree);

            // Analyze a CE tree and report results.
            analyzeTree(ceSimTree);

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
    
    /**
     * Analyze the tree...
     * - Run roll back and output results for each strategy.
     * - Run simulation (PSA for CE tree, trials for simple tree.
     */
    private void analyzeTree(Tree myTree) throws RemoteException {

        com.treeage.treeagepro.oi.Node myNode;
        com.treeage.treeagepro.oi.Node stratNode;
        Map<String, String> params;
        com.treeage.treeagepro.oi.Report report;
        com.treeage.treeagepro.oi.Report expVal;
        com.treeage.treeagepro.oi.Graph ceGraph;
        java.lang.String nodePath;

        try {

            System.out.println("--- Running roll back and getting EV for each strategy ---");

            // Turn rollback on
            params = Collections.singletonMap("enable", "true");
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

            // Run cost-effectiveness analysis on CE tree
            if (myTree.getCalculationMethod().equals("ct_costEff")) {
                System.out.println("--- Running Cost-Effectiveness analysis ---");
                report = myTree.runAnalysis(AnalysisType.costEffectivenes, null, myNode);
                System.out.println("CE text report:");
                outputTextReport(report.getTextReport());
                if (report.getGraph() != null) {
                    System.out.println("Saving CEA graph image.");
                    ceGraph = report.getGraph();
                    String graphFile = app.getWorkspacePath() + "/Example Models/Healthcare/CE-graph.png";
                    ceGraph.saveAsImage(graphFile);
                    System.out.println("CEA graph image file is " + graphFile);
                }
            }

            System.out.println("--- Running Monte Carlo simulation ---");

            // Setup simulation parameters, several just use default
            // Run PSA on this specific CE tree, trials on the sample tree
            params = new HashMap<String, String>();
            if (myTree.getCalculationMethod().equals("ct_costEff")) {
                params.put("samples", "100");
                params.put("trials", "0");
            } else {
                params.put("samples", "0");
                params.put("trials", "100");
            }

            report = myTree.runAnalysis(AnalysisType.monteCarlo, params, myNode);

            System.out.println("Simulation complete. Calc time: " + report.getCalcTime() + ", Status: " + report.getStatus());

            // Save simulation output as RPTX file.
            if(report.getStatus() == Status.OK) {
        		params.put(Report.RPTX_FILENAME, "Example Models/Healthcare/CE Markov Sampling");
        		report.saveAsRptx(params);
        	} else {
                System.out.println("Simulation failed with the following error message: \n" + report.getMessage());
                return;
        	}

            System.out.println("Simulation text report: ");
            outputTextReport(report.getTextReport());

            // Getting secondary charts
            if (!myTree.getCalculationMethod().equals("ct_costEff")) {
                // this particular example gets charts of CE analysis only
                return;
            }

            String imgDir = app.getWorkspacePath() + "/Example Models/Healthcare/";
            // 1. Cost-Effectiveness Scatterplot
            Report scatterReport = report.createReport("montecarlo-CE-scatter-chart", null);
            if (scatterReport.getGraph() != null) {
                String sctrImg = imgDir + "oi.example.ce.scatter.png";
                scatterReport.getGraph().saveAsImage(sctrImg);
                System.out.println("MC Scatterplot chart image file is: " + sctrImg);
            }
            // 2. Incremental Cost-Effectiveness
            System.out.println("Strategies Map: " + report.getValue("strategiesMap"));
            Map<String, String> iceParams = new HashMap<String, String>();
            iceParams.put("willingnessToPay", "50000");
            iceParams.put("strategy1", "1");
            iceParams.put("strategy2", "2");
            Report iceReport = report.createReport("montecarlo-ICE-scatter-chart", iceParams);
            if (iceReport.getGraph() != null) {
                String iceImg = imgDir + "oi.example.ice.scatter.png";
                iceReport.getGraph().saveAsImage(iceImg);
                System.out.println("MC ICE Scatterplot chart image file is: " + iceImg);
            }
            // 3. Acceptability Curve
            Map<String, String> acParams = new HashMap<String, String>();
            acParams.put("willingnessToPayLow", "0");
            acParams.put("willingnessToPayHigh", "100000");
            acParams.put("startIteration", "1");
            acParams.put("endIteration", "100");
            Report acReport = report.createReport("montecarlo-CEAC-chart", acParams);
            if (acReport.getGraph() != null) {
                String acImg = imgDir + "oi.example.ac.chart.png";
                acReport.getGraph().saveAsImage(acImg);
                System.out.println("MC Acceptability Curve chart image file is: " + acImg);
            }
            // 4. Strategy Selection
            Map<String, String> ssParams = new HashMap<String, String>();
            ssParams.put("willingnessToPay", "50000");
            ssParams.put("startIteration", "1");
            ssParams.put("endIteration", "100");
            Report ssReport = report.createReport("montecarlo-CE-strategy-chart", ssParams);
            if (ssReport.getGraph() != null) {
                String ssImg = imgDir + "oi.example.ss.chart.png";
                ssReport.getGraph().saveAsImage(ssImg);
                System.out.println("MC Strategy Selection chart image file is: " + ssImg);
            }
        System.out.println("Java OI example completed succesfully!");
        } catch (RemoteException re) {
            System.out.println("Error in analyzeTree.");
            throw re;
        } catch (Exception e) {
            System.out.println("Error in analyzeTree. Regular exception, not RemoteException \n"
                    + e.getMessage());
            return;
        }

    }

    /**
     * Output text report to the console
     */
    private void outputTextReport(com.treeage.treeagepro.oi.TextReport txtRpt)
            throws RemoteException {

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

        // System.out.println(txtRpt.toString());
    }
}
